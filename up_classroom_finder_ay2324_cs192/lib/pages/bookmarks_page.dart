import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/context.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/classroomdetail_page.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});
  
  @override
  BookmarksPageState createState() => BookmarksPageState();
}

class BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    var bmState = context.watch<MyAppState>();
    bmState.loadBookmarks();
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: const Color(0xff264B30),
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
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
                child: ListView.builder(
                  itemCount: bmState.activeBookmarks.length,
                  itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.arrow_drop_down),
                        title: Text(bmState.activeBookmarks[index]),
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        onTap: () {
                          showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height * 0.65, // scale height of bottom modal sheet\
                                child: ClassroomDetailPage(bmState.getClassrooomDetail(bmState.activeBookmarks[index])),
                              );
                            });
                        },
                  );
                },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextButton(
                    child: const Text("Back"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  /*
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // Remove 'AECH' from active bookmarks
                        bmState.removeBookmark(bmState.activeBookmarks[index]['NAME']);
                      });
                    },
                    child: const Text("Delete"),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
