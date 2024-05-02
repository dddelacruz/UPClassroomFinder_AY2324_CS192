import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPage createState() => _NotesPage();
}

class _NotesPage extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.loadNotes();
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
                appState.removeNoteAtIndex(index); // Remove note
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote(appState); // Add note
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addNote(MyAppState appState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: TextField(
            autofocus: true,
            onSubmitted: (value) {
              appState.addNote(value); // Add note
              Navigator.pop(context); // Close dialog
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
