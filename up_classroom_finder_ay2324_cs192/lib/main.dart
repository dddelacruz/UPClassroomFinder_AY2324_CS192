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