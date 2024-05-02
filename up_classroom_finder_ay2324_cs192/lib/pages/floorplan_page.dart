import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/notes_page.dart';

class FloorPlanPage extends StatelessWidget {
  const FloorPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bmState = context.watch<MyAppState>();
    bmState.loadBookmarks();
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
  }
}
