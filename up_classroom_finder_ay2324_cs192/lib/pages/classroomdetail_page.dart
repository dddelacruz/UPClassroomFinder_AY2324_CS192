import 'package:flutter/material.dart';

// hardcoded assets list for locations with floorplan
final floorplanImgList =[
  "UP AECH",
];


class ClassroomDetailPage extends StatelessWidget {
  final Map<String, dynamic> upclassroom;

  const ClassroomDetailPage(this.upclassroom, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // classroom name
      appBar: AppBar(
        title: Text(upclassroom['CLASSROOM NUMBER']),
      ),
    
      // classroom info
      body: ListView(
        children: [
          const SizedBox(
            height: 14,
          ),
    
          // floorplan

          // check if florplan image exists
          floorplanImgList.contains(upclassroom['LOCATION'])

              // if file exists, load image
              ? Dialog(
                  child: Image.asset(
                    "assets/floorplan_${upclassroom['LOCATION']}.jpg",
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                )
    
              // file does not exist
              : const Center(child: Text("No floorplan available as of now...")),
          const SizedBox(
            height: 14,
          ),
    
          // address
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xffffe9ea),
              child:
                  Icon(Icons.location_on, size: 18, color: Color(0xffd34343)),
            ),
            title: const Text("Address"),
            subtitle: Text(upclassroom['LOCATION']),
          ),
    
          // opening hours
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xffffe9ea),
              child: Icon(Icons.access_time_sharp,
                  size: 18, color: Color(0xffd34343)),
            ),
            title: const Text("Opening Hours"),
            subtitle: Text(upclassroom['OPENING HOURS']),
          ),
    
          // transportation
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xffffe9ea),
              child: Icon(Icons.emoji_transportation,
                  size: 18, color: Color(0xffd34343)),
            ),
            title: const Text("Transportation"),
            subtitle: Text(upclassroom['TRANSPORTATION']),
          ),
        ],
      ),
    
    );
  }
}
