import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'pages.dart';

class FloorPlanPage extends StatelessWidget {
  FloorPlanPage(this.location, {super.key});

  final String location;

  final db = FirebaseFirestore.instance;

  Future readBuildingInfo() async{
    final docRef = db.collection("buildinginfo").doc(location);

    return await docRef.get();
  }

  @override
  Widget build(BuildContext context) {
    // get building info from firebase 
    readBuildingInfo();

    return FutureBuilder(
      future: readBuildingInfo(),
      builder: (builder, snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to load floorplan.',
                style: TextStyle(fontSize: 18),
              ),
            );  
            
          } else if (snapshot.hasData) {
            final data = snapshot.data;

            if (data != null){
              return ListView(
                children: [
                  Container(
                      padding: const EdgeInsets.all(16),
                      height: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16), color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    location,
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(
                                    Icons.bookmark,
                                    size: 34,
                                    color: Color(0xff800000),
                                  )
                                ]),
                          ), // heading and bookmark row
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xfff9f9f9),
                                  child: Icon(Icons.arrow_back_ios_outlined,
                                      size: 18, color: Color(0xff800000)),
                                ),
                                Text("Floor plan image"),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xfff9f9f9),
                                  child: Icon(Icons.arrow_forward_ios,
                                      size: 18, color: Color(0xff800000)),
                                ),
                              ],
                            ),
                          ), // floorplan image row
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xffffe9ea),
                                  child: Icon(Icons.location_on,
                                      size: 18, color: Color(0xffd34343)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Address",
                                          style: TextStyle(color: Color(0xff999999)),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width - 80,
                                          child: Text(
                                            data['address'],
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ), // address row
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xffffe9ea),
                                  child: Icon(Icons.access_time_sharp,
                                      size: 18, color: Color(0xffd34343)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Opening Hours",
                                        style: TextStyle(color: Color(0xff999999))),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width - 80,
                                        child: Text(
                                          data['opening hours'],
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ), // hours row
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xffffe9ea),
                                  child: Icon(Icons.emoji_transportation,
                                      size: 18, color: Color(0xffd34343)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Transportation",
                                        style: TextStyle(color: Color(0xff999999)),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width - 80,
                                        child: Text(
                                          data['transportation'],
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ), // transportation row
                          const Divider(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NotesPage()),
                              );
                            },
                            child: const Text("Notes"),
                          ),
                        ],
                      ))
                ],
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