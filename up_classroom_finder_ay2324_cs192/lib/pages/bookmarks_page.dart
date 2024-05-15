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
        backgroundColor: const Color(0xff264B30),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: [
            Icon(Icons.bookmark, color: Color(0xff800000), size: 35,), 
            SizedBox(width: 5),
            Text('Bookmarks', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
          ],
        ),
        titleSpacing: 10
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
                        title: Text(bmState.getClassrooomDetail(bmState.activeBookmarks[index])["NAME"] + 
                        " (" + bmState.activeBookmarks[index] + ")"),
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        // onTap() is copied from map_page.dart, subject to change.
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
          ],
        ),
      ),
    );
  }
  
}