import 'package:flutter/material.dart';
import 'pages.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: ListView(
                  children: [
                    ListTile(
                        leading: const Icon(Icons.arrow_drop_down),
                        title: const Text("AECH"),
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                FloorPlanPage("AECH"),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                TextButton(
                  child: const Text("Back"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Container(),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Delete"),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
