import 'package:flutter/material.dart';

class ClassroomDetailPage extends StatelessWidget {
  final Map<String, dynamic> upclassroom;

  const ClassroomDetailPage({Key? key, required this.upclassroom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(upclassroom['CLASSROOM NUMBER']),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 14,
          ),
          upclassroom['LOCATION'] == "UP AECH"
              ? Dialog(
                  child: Image.asset(
                    "assets/floorplan_AECH.jpg",
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                )
              : Center(child: Text("No floorplan available as of now...")),
          SizedBox(
            height: 14,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffffe9ea),
              child:
                  Icon(Icons.location_on, size: 18, color: Color(0xffd34343)),
            ),
            title: Text("Address"),
            subtitle: Text(upclassroom['LOCATION']),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffffe9ea),
              child: Icon(Icons.access_time_sharp,
                  size: 18, color: Color(0xffd34343)),
            ),
            title: Text("Opening Hours"),
            subtitle: Text(upclassroom['OPENING HOURS']),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffffe9ea),
              child: Icon(Icons.emoji_transportation,
                  size: 18, color: Color(0xffd34343)),
            ),
            title: Text("Transportation"),
            subtitle: Text(upclassroom['TRANSPORTATION']),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => FloorPlanPage(),
          //       ),
          //     );
          //   },
          //   child: Text("View Floor Plan"),
          // ),
        ],
      ),
    );
  }
}
