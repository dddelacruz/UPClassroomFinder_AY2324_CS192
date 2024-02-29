import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      MaterialApp(
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
    );
  }
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
                    IconButton(icon: const Icon(Icons.schedule), onPressed: () {}),
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xff264B30),
              child: const Padding(
                padding:  const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.bookmark, 
                      color: Color(0xff800000),
                      size: 35,
                      ),
                    SizedBox(width: 7),
                    Text(
                      "Bookmarks",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: ListView(
                  children: [
                      ListTile(
                        leading: const Icon(Icons.arrow_drop_down),
                        title: Text("AECH"),
                        visualDensity:  const VisualDensity(horizontal: 0, vertical: -4),
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return ListView(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      height: 600,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Colors.white),
                                      child: const Column(
                                        children: [
                                          Padding(
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
                                          Padding(
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
                                          Divider(),
                                        ],
                                      ))
                                ],
                              );
                            },
                          );
                        },
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