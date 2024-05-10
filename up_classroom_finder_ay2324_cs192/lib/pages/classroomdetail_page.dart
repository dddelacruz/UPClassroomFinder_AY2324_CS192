import 'package:flutter/material.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/floorplan_page.dart';

class ClassroomDetailPage extends StatelessWidget {
  final Map<String, dynamic> upclassroom;

  const ClassroomDetailPage(this.upclassroom, {super.key});

  @override
  Widget build(BuildContext context) {
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Text(
                            upclassroom['NAME'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.bookmark,
                          size: 34,
                          color: Color(0xff800000),
                        )
                      ]),
                ), // heading and bookmark row
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Center(child: Text("Floorplan Image"))),
                    ],
                  ),
                ), // floorplan image row
                Divider(),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Text(upclassroom['ADDRESS'],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Text(upclassroom['OPENING HOURS'],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Text(upclassroom['TRANSPORTATION'],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ), // transportation row
                Divider(),
              ],
            ))
      ],
    );
  }
}
