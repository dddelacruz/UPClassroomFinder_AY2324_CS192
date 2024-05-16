import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/floorplan_listofimages.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/context.dart';

class ClassroomDetailPage extends StatelessWidget {
  final Map<String, dynamic> upclassroom;

  const ClassroomDetailPage(this.upclassroom, {super.key});

  @override
  Widget build(BuildContext context) {
    var bmState = context.watch<MyAppState>();
    bmState.loadBookmarks;
    return ListView(
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(
                            upclassroom['NAME'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Bookmark button section
                        IconButton(
                          icon: Icon(
                            bmState.activeBookmarks
                                    .contains(upclassroom['CLASSROOM NUMBER'])
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 34,
                            color: const Color(0xff800000),
                          ),
                          onPressed: () {
                            if (bmState.activeBookmarks
                                .contains(upclassroom['CLASSROOM NUMBER'])) {
                              bmState.removeBookmark(upclassroom[
                                  'CLASSROOM NUMBER']); // Remove the bookmark if shaded
                            } else {
                              bmState.addBookmark(upclassroom[
                                  'CLASSROOM NUMBER']); // Add the bookmark if not shaded
                            }
                          },
                        ),
                      ]),
                ), // heading and bookmark row
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: InstaImageViewer(
                              child: FloorPlanImagePageList(
                                  buildingName: upclassroom['LOCATION'],
                                  floorNumber: upclassroom['FLOOR NUMBER']))),
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
                        child: Icon(Icons.numbers_sharp,
                            size: 18, color: Color(0xffd34343)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Classroom and Floor Number",
                                style: TextStyle(color: Color(0xff999999))),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Text(
                                  upclassroom['CLASSROOM NUMBER'] +
                                      ' - ' +
                                      upclassroom['FLOOR NUMBER'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ), // classroom number and floor number row

                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Address",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Text(upclassroom['ADDRESS'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
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
                            const Text("Opening Hours",
                                style: TextStyle(color: Color(0xff999999))),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Text(upclassroom['OPENING HOURS'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
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
                              child: Text(upclassroom['TRANSPORTATION'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ), // transportation row
                const Divider(),
              ],
            ))
      ],
    );
  }
}
