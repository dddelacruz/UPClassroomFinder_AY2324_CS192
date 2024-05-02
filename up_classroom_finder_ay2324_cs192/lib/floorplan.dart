import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'notes.dart';

class FloorPlanPage extends StatelessWidget {
  FloorPlanPage(this.location);

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
            //print(data['name']);

            if (data != null){
              //final buildings = data.map((e) => Building(e['name'], e['lat'], e['long']));
              //print("data is not null");
              return ListView(
                children: [
                  Container(
                      padding: EdgeInsets.all(16),
                      height: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16), color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    location,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
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
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xffffe9ea),
                                  child: Icon(Icons.location_on,
                                      size: 18, color: Color(0xffd34343)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address",
                                        style: TextStyle(color: Color(0xff999999)),
                                      ),
                                      Text(data['address'],
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ), // address row
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xffffe9ea),
                                  child: Icon(Icons.access_time_sharp,
                                      size: 18, color: Color(0xffd34343)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Opening Hours",
                                          style: TextStyle(color: Color(0xff999999))),
                                      Text(data['opening hours'],
                                          style: TextStyle(fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ), // hours row
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xffffe9ea),
                                  child: Icon(Icons.emoji_transportation,
                                      size: 18, color: Color(0xffd34343)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Transportation",
                                        style: TextStyle(color: Color(0xff999999)),
                                      ),
                                      Text(data['transportation'],
                                          style: TextStyle(fontWeight: FontWeight.bold))
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

          return Center(
              child: CircularProgressIndicator(),
            );

        }  
      
      /*ListView(
        children: [
          Container(
              padding: EdgeInsets.all(16),
              height: 600,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            location,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Icon(
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
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xffffe9ea),
                          child: Icon(Icons.location_on,
                              size: 18, color: Color(0xffd34343)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Address",
                                style: TextStyle(color: Color(0xff999999)),
                              ),
                              Text("Address Info",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        )
                      ],
                    ),
                  ), // address row
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xffffe9ea),
                          child: Icon(Icons.access_time_sharp,
                              size: 18, color: Color(0xffd34343)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Opening Hours",
                                  style: TextStyle(color: Color(0xff999999))),
                              Text("Opening Hours Info",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ), // hours row
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xffffe9ea),
                          child: Icon(Icons.emoji_transportation,
                              size: 18, color: Color(0xffd34343)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transportation",
                                style: TextStyle(color: Color(0xff999999)),
                              ),
                              Text("Transportation Info",
                                  style: TextStyle(fontWeight: FontWeight.bold))
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
      ),*/
    );
  }
}