import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/bookmarks_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/classroomdetail_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/floorplan_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/map_image.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/notes_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/schedule_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List _allResults = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    getClientStream();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    //print(_searchController.text);
    searchResultList();
  }

  void searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientSnapshot in _allResults) {
        var name = clientSnapshot['NAME'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('upclassroom')
        .orderBy('NAME')
        .get();
    setState(() {
      _allResults = data.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C0000),
        title: CupertinoSearchTextField(
          controller: _searchController,
        ),
        leading: _searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Clear the search text when pressing back
                  //MapPage();
                  _searchController.clear();
                  // Update search results after clearing text
                  searchResultList();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                },
              )
            : null, // Conditionally render the back button
      ),
      body: Stack(
        children: <Widget>[
          // Map image
          if (_resultList.isEmpty && _searchController.text == "")
            Positioned.fill(
              child: MapIMG(),
            ),
          if (_resultList.isNotEmpty)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SearchResultsPage(_searchController, _resultList),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigationBar(),
          ),
        ],
      ),
    );
  }
}

class SearchResultsPage extends StatelessWidget{
  const SearchResultsPage(this.searchController, this.resultList);

  final List resultList;
  final TextEditingController searchController;

  @override
  build(BuildContext context) {
    return Container(
      color: searchController.text.isEmpty
          ? Colors.transparent
          : Colors.white,
      child: ListView.builder(
        itemCount: resultList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(resultList[index]['NAME']),
            subtitle: Text(resultList[index]['LOCATION']),
            trailing: Text(resultList[index]['FLOOR NUMBER']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassroomDetailPage(
                    upclassroom: resultList[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NavigationBar extends StatelessWidget{
  @override
  build(BuildContext context){
    return BottomAppBar(
      color: Color(0xFF8C0000),
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
        data: IconThemeData(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SchedulePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookmarksPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}