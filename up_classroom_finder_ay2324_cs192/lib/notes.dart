import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppState extends ChangeNotifier {
  List<String> notes = [];

  // Load notes from shared preferences
  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotes = prefs.getStringList('notes');
    if (savedNotes != null) {
      notes = savedNotes;
    }
    notifyListeners();
  }

  // Save notes to shared preferences
  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', notes);
  }

  // Add a note
  void addNote(String note) {
    notes.add(note);
    saveNotes();
    notifyListeners();
  }

  // Remove a note
  void removeNoteAtIndex(int index) {
    notes.removeAt(index);
    saveNotes();
    notifyListeners();
  }

  // Bookmark State
  List<String> activeBookmarks = []; // Maintain a list of active bookmarks

  // Load activeBookmarks from shared preferences
  Future<void> loadBookmarks() async {
    SharedPreferences prefs_bm = await SharedPreferences.getInstance();
    List<String>? savedBookmarks = prefs_bm.getStringList('activeBookmarks');
    if (savedBookmarks != null) {
      activeBookmarks = savedBookmarks;
    }
    notifyListeners();
  }

  // Save activeBookmarks to shared preferences
  Future<void> saveBookmark() async {
    SharedPreferences prefs_bm = await SharedPreferences.getInstance();
    await prefs_bm.setStringList('activeBookmarks', activeBookmarks);
  }

  // Add a bookmark
  void addBookmark(String bookmark) {
    activeBookmarks.add(bookmark);
    saveBookmark();
    notifyListeners();
  }

  // Remove a bookmark
  void removeBookmark(String bookmark) {
    activeBookmarks.remove(bookmark);
    saveBookmark();
    notifyListeners();
  }
}

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
