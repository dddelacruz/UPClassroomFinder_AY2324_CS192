import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/building_listofimage.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/notes_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/context.dart';

// hardcoded assets list for locations with floorplan
final floorplanImgList = ["AECH", "EEEI", "CSLib", "NIGS", "DMMME"];

class FloorPlanPage extends StatelessWidget {
  FloorPlanPage(this.location, {super.key});

  final String location;

  final db = FirebaseFirestore.instance;

  Future readBuildingInfo() async {
    final docRef = db.collection("buildinginfo").doc(location);

    return await docRef.get();
  }

  @override
  Widget build(BuildContext context) {
    // get building info from firebase
    readBuildingInfo();

    return FutureBuilder(
        future: readBuildingInfo(),
        builder: (builder, snapshot) {
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

              if (data != null) {
                return ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
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
        });
  }
}

class BuildingInfo extends StatelessWidget {
  const BuildingInfo(this.location, this.data, {super.key});

  final String location;
  final dynamic data;

  @override
  build(BuildContext context) {
    return Column(
      children: [
        HeadingRow(location), // heading and bookmark row
        FloorplanImgRow(location), // floorplan image row
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
                  child: Text(data['transportation'],
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
                const Text("Opening Hours",
                    style: TextStyle(color: Color(0xff999999))),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Text(data['opening hours'],
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
            child: Icon(Icons.location_on, size: 18, color: Color(0xffd34343)),
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
  const FloorplanImgRow(
    this.location, {
    super.key,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // what are these arrows for?
          /* const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xfff9f9f9),
            child: Icon(Icons.arrow_back_ios_outlined,
                size: 18, color: Color(0xff800000)),
          ), */

          //Text("Floor plan image"),
          floorplanImgList.contains(location)
              // if file exists, load image
              ? SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: InstaImageViewer(
                    child: BuildingImageList(
                      location: location,
                    ),
                  ),
                )
              // file does not exist
              : const Center(child: Text("No floorplan available")),

          const SizedBox(
            height: 14,
          ),

          /* const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xfff9f9f9),
            child: Icon(Icons.arrow_forward_ios,
                size: 18, color: Color(0xff800000)),
          ), */
        ],
      ),
    );
  }
}

class HeadingRow extends StatelessWidget {
  const HeadingRow(this.location, {super.key});

  final String location;

  @override
  build(BuildContext context) {
    var bmState = context.watch<MyAppState>();
    bmState.loadBookmarks();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Text(
            location,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Icon(
          Icons.bookmark,
          size: 34,
          color: Color(0xff800000),
        ),

        // implementation for bookmarks button is a Future function
        // needs to be fixed in order for floorplan page to load properly
        /* IconButton(
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
          ), */
      ]),
    );
  }
}
