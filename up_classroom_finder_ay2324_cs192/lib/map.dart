import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'pages.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Map image
          const Positioned.fill(
            child: MapIMG(),
          ),
          // Search bar
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF8C0000), // Maroon color for the search bar
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    icon: Icon(Icons.search, color: Colors.white),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          // Bottom navigation bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomAppBar(
              color: const Color(0xFF8C0000), // BottomAppBar
              shape: const CircularNotchedRectangle(),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white), // icon color
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesPage()),
                          );
                        }),
                    IconButton(
                        icon: const Icon(Icons.schedule),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SchedulePage()),
                          );
                        }),
                    IconButton(
                        icon: const Icon(Icons.bookmark),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookmarksPage()),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MapIMG extends StatefulWidget {
  const MapIMG({super.key});

  @override
  State<MapIMG> createState() => _MapIMGState();
}


class Building{
  late String name;
  late double lat;
  late double long;
  
  Building({
    required this.name,
    required this.lat,
    required this.long
  });
}


class _MapIMGState extends State<MapIMG> {
  // get list of buildings from firebase
  //  1. read data from buildings collection
  //  2. convert to list of buildings
  Future<List> readBuildings() async{
    CollectionReference ref = FirebaseFirestore.instance.collection("buildings");
    
    QuerySnapshot snap = await ref.get();

    final allData = snap.docs.map((doc) => doc.data()).toList();

    return allData;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readBuildings(),
      builder: (builder, snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Marker locations failed to load.',
                style: TextStyle(fontSize: 18),
              ),
            );  
            
          } else if (snapshot.hasData) {
            final data = snapshot.data;

            if (data != null){
              final buildings = data.map((e) => Building(name: e['name'], lat: e['lat'], long: e['long']));

              return Scaffold(
                appBar: AppBar(
                  title: const Text('UP Classroom Finder'),
                ),
                body: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(14.64860,121.06855),
                    initialZoom: 18,
                    interactionOptions: InteractionOptions(flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(
                      markers: 
                      // dynamically generate markers based on list of buildings
                        buildings.map((b) => 
                          Marker(
                            point: LatLng(b.lat,b.long),
                            width: 80,
                            height: 80,
                            child: GestureDetector(
                              onTap: (){
                                readBuildings();
                                showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          FloorPlanPage(b.name),
                                    );
                              },
                              child: const Icon(
                                Icons.location_pin,
                                size: 50
                              ),
                            ),
                          )
                        ).toList(),
                    ),
                  ],
                )
              );
            }
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }   
    );
  }
}


