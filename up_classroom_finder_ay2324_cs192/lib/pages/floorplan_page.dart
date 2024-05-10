import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/notes_page.dart';

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
                      child: BuildingInfo(location, data),
                      ),
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


class BuildingInfo extends StatelessWidget{
  const BuildingInfo(this.location, this.data, {super.key});

  final String location;
  final dynamic data;

  @override
  build(BuildContext context){
    return Column(
      children: [
        HeadingRow(location), // heading and bookmark row
        const FloorplanImgRow(), // floorplan image row
        const Divider(),
        AddressRow(data: data), // address row
        HoursRow(data: data), // hours row
        TransportationRow(data: data), // transportation row
        const Divider(),
        const NotesRow(), // notes row
      ],
    );
  }
}

class NotesRow extends StatelessWidget {
  const NotesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotesPage()),
        );
      },
      child: const Text("Notes"),
    );
  }
}

class TransportationRow extends StatelessWidget {
  const TransportationRow({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class HoursRow extends StatelessWidget {
  const HoursRow({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class AddressRow extends StatelessWidget {
  const AddressRow({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class FloorplanImgRow extends StatelessWidget {
  const FloorplanImgRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
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
    );
  }
}

class HeadingRow extends StatelessWidget{
  const HeadingRow(this.location, {super.key});

  final String location;

  @override 
  build(BuildContext context){
    var bmState = context.watch<MyAppState>();
    bmState.loadBookmarks();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            location,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              bmState.activeBookmarks.contains('AECH')
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              size: 34,
              color: Color(0xff800000),
            ),
            onPressed: () {
              if (bmState.activeBookmarks.contains('AECH')) {
                bmState.removeBookmark(
                    'AECH'); // Remove the bookmark if shaded
              } else {
                bmState.addBookmark(
                    'AECH'); // Add the bookmark if not shaded
              }
            },
          ),
        ]),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/notes_page.dart';

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
    var bmState = context.watch<MyAppState>();
    bmState.loadBookmarks();

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
                         // heading and bookmark row
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "AECH",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: Icon(
                                    bmState.activeBookmarks.contains('AECH')
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    size: 34,
                                    color: Color(0xff800000),
                                  ),
                                  onPressed: () {
                                    if (bmState.activeBookmarks.contains('AECH')) {
                                      bmState.removeBookmark(
                                          'AECH'); // Remove the bookmark if shaded
                                    } else {
                                      bmState.addBookmark(
                                          'AECH'); // Add the bookmark if not shaded
                                    }
                                  },
                                ),
                              ]),
                        ),
                        
                        
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
    /*
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
                          "AECH",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(
                            bmState.activeBookmarks.contains('AECH')
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 34,
                            color: Color(0xff800000),
                          ),
                          onPressed: () {
                            if (bmState.activeBookmarks.contains('AECH')) {
                              bmState.removeBookmark(
                                  'AECH'); // Remove the bookmark if shaded
                            } else {
                              bmState.addBookmark(
                                  'AECH'); // Add the bookmark if not shaded
                            }
                          },
                        ),
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
    );
  }*/
}
 */