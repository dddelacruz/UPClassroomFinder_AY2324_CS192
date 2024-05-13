// context.dart contains information/state of important variables such as saved notes, schedule, and bookmarks
// also included is the shared preferences implementation for local storage

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:up_classroom_finder_ay2324_cs192/pages/notes_page.dart';

class MyAppState extends ChangeNotifier {
  // _resultList from MapPage (used in bookmarks_page.dart)
  List _resultList = []; // list of filtered results from database, added so that bookmarks_page can see _resultList
  
  List get resultList => _resultList;

  void updateResultList(List newList) {
    _resultList = newList;
    notifyListeners();
  }

  dynamic getClassrooomDetail(String name){
    for (int i = 0; i < _resultList.length; i++) {
      if (name == _resultList[i]['NAME']){
        return _resultList[i];
      }
    }
  }


  // Notes state is saved in local storage using shared preferences
  List<String> notes = []; // contains saved notes in map page
  
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

  void addNote(String note) {
    notes.add(note);
    saveNotes();
    notifyListeners();
  }

  void removeNoteAtIndex(int index) {
    notes.removeAt(index);
    saveNotes();
    notifyListeners();
  }

  // Bookmarks state is saved in local storage using shared preferences
  List<String> activeBookmarks = []; // maintain a list of active bookmarks

  // Load activeBookmarks from shared preferences
  Future<void> loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedBookmarks = prefs.getStringList('activeBookmarks');
    if (savedBookmarks != null) {
      activeBookmarks = savedBookmarks;
    }
    notifyListeners();
  }

  // Save activeBookmarks to shared preferences
  Future<void> saveBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('activeBookmarks', activeBookmarks);
  }

  void addBookmark(String bookmark) {
    activeBookmarks.add(bookmark);
    saveBookmark();
    notifyListeners();
  }

  void removeBookmark(String bookmark) {
    activeBookmarks.remove(bookmark);
    saveBookmark();
    notifyListeners();
  }

  // Schedule state is saved in local storage using shared preferences
  List<Map<String, String>> schedules = [];

  // Load schedule from shared preferences
  Future<void> loadSched() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? schedulesJsonFromPrefs = prefs.getString('schedules');
    if (schedulesJsonFromPrefs != null) {
      List<dynamic> decoded = json.decode(schedulesJsonFromPrefs);
      schedules = List<Map<String, String>>.from(decoded.map((x) => Map<String, String>.from(x)));
    }
    notifyListeners();
  }

  // Save sched to shared preferences
  Future<void> saveSched() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(schedules);
    await prefs.setString('schedules', jsonData);
    notifyListeners();
  }

  void addSched(Map<String, String> sched) {
    schedules.add(sched);
    saveSched();
    notifyListeners();
  }

  void removeSchedAtIndex(int index) {
    schedules.removeAt(index);
    saveSched();
    notifyListeners();
  }
}