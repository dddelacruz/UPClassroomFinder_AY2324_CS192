import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';



import 'notes.dart';
import 'bookmark.dart';
import 'schedule.dart';
import 'floorplan.dart';
import 'firebase_options.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Map image
          Positioned.fill(
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
                  color: Color(0xFF8C0000), // Maroon color for the search bar
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
              color: Color(0xFF8C0000), // BottomAppBar
              shape: const CircularNotchedRectangle(),
              child: IconTheme(
                data: IconThemeData(color: Colors.white), // icon color
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
  var name;
  var lat;
  var long;

  
  Building(var name, var lat, var long){
    this.name = name;
    this.lat = lat;
    this.long = long;
  }

  /*
  Building({
    this.name,
    this.lat,
    this.long
  });
  

  factory Building.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,){
      final data = snapshot.data();
      return Building(
        name: data?['name'],
        lat: data?['lat'],
        long: data?['long'],
      );
    }
  */
}


class _MapIMGState extends State<MapIMG> {
  // for testing
  //var buildings = [Building('AECH', 14.6486, 121.06855), Building('EEEI', 14.64951, 121.06827), Building('CSLib', 14.64925, 121.06918)];
  //

  // get list of buildings from firebase
  //  1. read data from buildings collection
  //  2. convert o list of buildings
  Future<List> readBuildings() async{
    //print("getting buildings from database");

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
        // Checking if future is resolved
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: TextStyle(fontSize: 18),
              ),
            );  
            
            // if we got our data
          } else if (snapshot.hasData) {
            // Extracting data from snapshot object
            final data = snapshot.data;
            //print(data);

            if (data != null){
              final buildings = data.map((e) => Building(e['name'], e['lat'], e['long']));

              return Scaffold(
              appBar: AppBar(
                title: Text('Map'),
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
                      
                      /*
                      Marker(
                        point: LatLng(14.64866,121.06866),
                        width: 80,
                        height: 80,
                        child: GestureDetector(
                          onTap: (){
                            showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const FloorPlanPage(),
                                );
                          },
                          child: Icon(
                            Icons.location_pin,
                            size: 50
                          ),
                        ),
                      ),*/
                  ),
                ],
              ));
            }
        }
          }

          return Center(
              child: CircularProgressIndicator(),
            );

        }   
    );
  }
}


