import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyAppState extends ChangeNotifier {
  // Initialize list for notes
  List<String> notes = [];
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
        title: Text('Notes', style: TextStyle(color: Colors.white)),
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