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
    var appState = context.watch<MyAppState>();   // Get App state from context.dart
    appState.loadNotes();                         // Load previously saved notes
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
            Icon(Icons.note_alt_outlined, color: Color(0xff800000), size: 35,), 
            SizedBox(width: 5),
            Text('Notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
          ],
        ),
        titleSpacing: 10
      ),
      body: ListView.builder(
        itemCount: appState.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appState.notes[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit selected note
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    editNote(context, appState, index);
                  },
                ),
                // Delete selected note
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    appState.removeNoteAtIndex(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote(appState); // Add note
        },
        child: const Icon(Icons.add_box_outlined),
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
              appState.addNote(value);
              Navigator.pop(context);
            },
            decoration: const InputDecoration(
              hintText: 'Enter your note',
            ),
          ),
        );
      },
    );
  }

  void editNote(BuildContext context, MyAppState appState, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: TextField(
            autofocus: true,
            controller: TextEditingController(text: appState.notes[index]),
            onChanged: (value) {
              appState.notes[index] = value; // Update note in context.dart
              appState.saveNotes();          // Save new note, important: notifylisteners
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}