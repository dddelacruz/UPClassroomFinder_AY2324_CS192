import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/context.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  NotesPageState createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.loadNotes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff264B30),
      ),
      body: ListView.builder(
        itemCount: appState.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appState.notes[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
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
        child: const Icon(Icons.add),
      ),
    );
  }

  void addNote(MyAppState appState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: TextField(
            autofocus: true,
            onSubmitted: (value) {
              appState.addNote(value); // Add note
              Navigator.pop(context); // Close dialog
            },
            decoration: const InputDecoration(
              hintText: 'Enter your note',
            ),
          ),
        );
      },
    );
  }
}