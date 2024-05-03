import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/floorplan_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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