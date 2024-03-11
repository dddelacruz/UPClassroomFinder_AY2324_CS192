import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'UP CLASSROOM FINDER',
          theme: ThemeData(
            primaryColor: Color(0xFF8C0000), //Maroon
          
            primarySwatch: MaterialColor(
              0xFF8C0000,
              <int, Color>{
                50: Color(0xFFF8E0E0),
                100: Color(0xFFF1C1C1),
                200: Color(0xFFE9A1A1),
                300: Color(0xFFE28282),
                400: Color(0xFFDB6262),
                500: Color(0xFFD44242),
                600: Color(0xFF8C0000),
                700: Color(0xFF8C0000),
                800: Color(0xFF8C0000),
                900: Color(0xFF8C0000),
              },
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const MapPage(),
            ),
      );
  }
}

class MyAppState extends ChangeNotifier {
  // Initialize list for notes
  List<String> notes = [];

}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Map image
          Positioned.fill(
            child: Image.asset(
              'assets/map.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Search bar
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Color(0xFF8C0000), // Maroon color for the search bar
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    icon: Icon(Icons.search, color: Colors.white),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white), 
                  ),
                ),
              ),
            ),
          ),
          // Bottom navigation bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomAppBar(
              color: Color(0xFF8C0000), // BottomAppBar
              shape: const CircularNotchedRectangle(),
              child: IconTheme(
                data: IconThemeData(color: Colors.white), // icon color 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.schedule), onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SchedulePage()),
                      );
                    }),
                    IconButton(icon: const Icon(Icons.bookmark), onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookmarksPage()),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookmarksPage extends StatelessWidget{
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks',
                  style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,)),
        backgroundColor: Color(0xff264B30),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(
                        Icons.bookmark, 
                        color: Color(0xff800000),
                        size: 35,
                        ),
        ),
        titleSpacing: 10,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: ListView(
                  children: [
                      ListTile(
                        leading: const Icon(Icons.arrow_drop_down),
                        title: Text("AECH"),
                        visualDensity:  const VisualDensity(horizontal: 0, vertical: -4),
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) => const FloorPlanPage(),
                          );
                        }
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:[
                  TextButton(
                    child: Text("Back"),
                    onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  Expanded(
                    child: Container(),
                  ),
                  TextButton(
                    onPressed: (){},
                    child: Text("Delete"),
                    ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// *** Notes page widget ***
class NotesPage extends StatefulWidget {
  @override
  _NotesPage createState() => _NotesPage();
}
// *** Notes page widget ***

// *** Notes page state ***
class _NotesPage extends State<NotesPage> {
  @override
  
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes',
                  style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff264B30),
      ),
      body: ListView.builder(
        itemCount: appState.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appState.notes[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  appState.notes.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote(appState);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addNote(appState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: TextField(
            autofocus: true,
            onSubmitted: (value) {
              setState(() {
                appState.notes.add(value);
              });
              Navigator.pop(context); // Close the dialog
            },
            decoration: InputDecoration(
              hintText: 'Enter your note',
            ),
          ),
        );
      },
    );
  }
}
// *** Notes page state ***


class FloorPlanPage extends StatelessWidget{
  const FloorPlanPage({super.key});

  @override
  Widget build(BuildContext context){
    return ListView(
          children: [
            Container(
                padding: EdgeInsets.all(16),
                height: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "AECH",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address",
                                  style:
                                      TextStyle(color: Color(0xff999999)),
                                ),
                                Text("Address Info",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
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
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text("Opening Hours",
                                    style: TextStyle(
                                        color: Color(0xff999999))),
                                Text("Opening Hours Info",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
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
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Transportation",
                                  style:
                                      TextStyle(color: Color(0xff999999)),
                                ),
                                Text("Transportation Info",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // transportation row
                    const Divider(),
                    TextButton(
                      onPressed: (){
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


class SchedulePage extends StatelessWidget{
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule',
                  style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,)),
                  backgroundColor: Color(0xff264B30),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                        Icons.calendar_today, 
                        color: Color(0xff800000),
                        size: 35,
                        ),
        ),
        titleSpacing: 10,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10.0),
                child: ListView(
                  children: [
                      ListTile(
                        title: Text("MONDAY", style: TextStyle(fontWeight: FontWeight.bold)),
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      ),
                      ListTile(
                        title: Table(
                          children: [
                            TableRow(
                              children: <Widget>[
                                TableCell(
                                  child: Container(
                                    child: Center(child: Text("time", textAlign: TextAlign.center,)),
                                    height: 35
                                    )
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(child: Text("subject", textAlign: TextAlign.center,)),
                                    height: 35
                                    )
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(child: 
                                      TextButton(
                                        child: Text("location", textAlign: TextAlign.center, 
                                        style: TextStyle(color: Color(0xff800000))),
                                        onPressed: (
                                        ){},
                                        )
                                      ),
                                    height: 35
                                    )
                                ),
                              ]
                          )],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:[
                  TextButton(
                    child: Text("Back"),
                    onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  Expanded(
                    child: Container(),
                  ),
                  TextButton(
                    onPressed: (){},
                    child: Text("Edit"),
                    ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}