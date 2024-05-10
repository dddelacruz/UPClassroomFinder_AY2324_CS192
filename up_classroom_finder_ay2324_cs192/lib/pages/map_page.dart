import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/bookmarks_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/classroomdetail_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/map_image.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/notes_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/schedule_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // functions and variables for search bar

  List _allData = []; // list of all items in database
  List _resultList = []; // list of filtered results from database
  final TextEditingController _searchController = TextEditingController();
  final _focus = FocusNode();

  // add listener to search bar
  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    getClientStream();
    super.initState();
  }

  // dispose of listener
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // fetch new results list whenever search bar text changes
  void _onSearchChanged() {
    searchResultList();
  }

  // get list of search results
  void searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientSnapshot in _allData) {
        var name = clientSnapshot['NAME'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapshot);
        }
      }
    } else {
      showResults = List.from(_allData);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  // read from database for search results
  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('upclassroom')
        .orderBy('NAME')
        .get();
    setState(() {
      _allData = data.docs.map((doc) => doc.data()).toList();
    });
  }

  // functions for search bar END

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C0000),

        // search bar
        title: CupertinoSearchTextField(
          controller: _searchController,
          focusNode: _focus,
        ),

        // show back button when search bar is being used
        leading: (_focus.hasFocus)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Clear the search text when pressing back
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
          // if search bar is not being used, show map image
          if (!_focus.hasFocus)
            const Positioned.fill(
              child: MapIMG(),
            ),

          // if search bar is being used show search results
          if (_focus.hasFocus)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SearchResultsPage(_searchController, _resultList),
            ),

          // navigation bar is always present
          const Positioned(
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

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage(this.searchController, this.resultList, {super.key});

  final List resultList;
  final TextEditingController searchController;

  @override
  build(BuildContext context) {
    // if back button is pressed, go back to showing map image
    return PopScope(
      canPop: false,
      onPopInvoked: (bool popped) {
        if (!popped) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => MapPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Container(
        // if search results is empty, show blank screen
        color:
            searchController.text.isEmpty ? Colors.transparent : Colors.white,

        // if search results is not empty, show list of results
        child: ListView.builder(
          itemCount: resultList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(resultList[index]['NAME']),
              subtitle: Text(resultList[index]['LOCATION']),
              trailing: Text(resultList[index]['FLOOR NUMBER']),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ClassroomDetailPage(resultList[index]),
                //   ),
                // );
                showModalBottomSheet<dynamic>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height *
                            0.65, // scale height of bottom modal sheet
                        child: ClassroomDetailPage(resultList[index]),
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  build(BuildContext context) {
    // buttom app bar for navigation
    return BottomAppBar(
      color: const Color(0xFF8C0000),
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
        data: const IconThemeData(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // button to notes page
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesPage()),
                );
              },
            ),

            // button to schedule page
            IconButton(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SchedulePage()),
                );
              },
            ),

            // button to bookmarks page
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
