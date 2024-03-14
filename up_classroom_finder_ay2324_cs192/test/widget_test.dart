// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:up_classroom_finder_ay2324_cs192/main.dart';

void main() {
  group('MapPage Tests', () {
    testWidgets('MapPage UI Test', (WidgetTester tester) async {

      // Build MapPage widget
      await tester.pumpWidget(const MyApp());

      // Verify existence of map image
      expect(find.byType(Image), findsOneWidget);

      // Verify existence of search bar
      expect(find.byType(TextField), findsOneWidget);

      // Verify existence of bottom navigation bar icons
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.schedule), findsOneWidget);
      expect(find.byIcon(Icons.bookmark), findsOneWidget);

      // Verify working search bar functionality
      await tester.enterText(find.byType(TextField), 'hi');

      // Verify working Bookmark button
      final buttonFinder = find.byIcon(Icons.bookmark);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(BookmarksPage), findsOneWidget);
    });
  });
  
  group('BookmarksPage Tests', () {
    testWidgets('BookmarksPage UI Test', (WidgetTester tester) async {

      // Build BookmarksPage widget
      await tester.pumpWidget(const MyApp());

      final buttonFinder = find.byIcon(Icons.bookmark);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(BookmarksPage), findsOneWidget);

      // Find bookmark title and icon
      expect(find.byIcon(Icons.bookmark), findsOneWidget);
      expect(find.text('Bookmarks'), findsOneWidget);

      // Find an existing bookmark
      final bookmarkFinder = find.byType(ListTile);
      await tester.tap(bookmarkFinder);
      await tester.pumpAndSettle();
      expect(find.byType(FloorPlanPage), findsOneWidget);

      // Check if tapping outside ModalBottomSheet returns screen to Bookmarks
      await tester.tap(find.byType(Scaffold), warnIfMissed: false);
      await tester.pump();
      expect(find.byType(BookmarksPage), findsOneWidget);    // Verify if BookmarksPage is visible again

      // Verify working Back button
      bool isBackTextButton(Widget widget) {
        if (widget is TextButton) {
          final textButton = widget;
          return textButton.child is Text && (textButton.child as Text).data == 'Back';
        }
        return false;
      }
      expect(find.byWidgetPredicate(isBackTextButton), findsOneWidget);

      await tester.press(find.byWidgetPredicate(isBackTextButton), warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.byType(MyApp), findsOneWidget);
    });
  });

  group('FloorPlanPage Tests', () {
    testWidgets('Floorplan UI Test', (WidgetTester tester) async {

      // Build Floorplan widget
      await tester.pumpWidget(const MyApp());

      final buttonFinder = find.byIcon(Icons.bookmark);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(BookmarksPage), findsOneWidget);

      final bookmarkFinder = find.byType(ListTile);
      await tester.tap(bookmarkFinder);
      await tester.pumpAndSettle();
      expect(find.byType(FloorPlanPage), findsOneWidget);

      // Verify working Notes button
      bool isNotesTextButton(Widget widget) {
        if (widget is TextButton) {
          final textButton = widget;
          return textButton.child is Text && (textButton.child as Text).data == 'Notes';
        }
        return false;
      }

      final notesbuttonFinder = find.byWidgetPredicate(isNotesTextButton);
      await tester.tap(notesbuttonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(NotesPage), findsOneWidget);
    });
  });

  group('NotesPage Tests', () { 
    testWidgets('Floorplan UI Test', (WidgetTester tester) async {

      // Build Notes widget
      await tester.pumpWidget(const MyApp());

      final buttonFinder = find.byIcon(Icons.edit);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(NotesPage), findsOneWidget);
    
      final addbuttonFinder = find.byType(FloatingActionButton);
      final deletebuttonFinder = find.byType(IconButton);
      
      // Verify proper loading of Notes buttons
      expect(addbuttonFinder, findsOneWidget);

      // Test adding notes
      await tester.tap(addbuttonFinder, warnIfMissed: false);
      await tester.pump();
      await tester.enterText(find.byType(TextField), 'hello world!');
      await tester.pump();
      expect(find.text('hello world!'), findsOneWidget);

      // Test removing notes
      expect(deletebuttonFinder, findsOneWidget);
      await tester.tap(deletebuttonFinder, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.text('hello world!'), findsNothing);
    });
  });

  group('SchedulePage Tests', () { 
    testWidgets('SchedulePage UI Test', (WidgetTester tester) async {

      // Build SchedulePage widget
      await tester.pumpWidget(const MyApp());

      final buttonFinder = find.byIcon(Icons.schedule);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(SchedulePage), findsOneWidget);

      // Verify SchedulePage title and icon
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.text('Schedule'), findsOneWidget);

      // Check working bookmarks button (AECH sample)
      bool isAECHTextButton(Widget widget) {
        if (widget is TextButton) {
          final textButton = widget;
          return textButton.child is Text && (textButton.child as Text).data == 'AECH';
        }
        return false;
      }

      final aechbuttonFinder = find.byWidgetPredicate(isAECHTextButton);
      await tester.tap(aechbuttonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(FloorPlanPage), findsOneWidget);

      // Check if tapping outside ModalBottomSheet returns screen to SchedulePage
      await tester.tap(find.byType(Scaffold), warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.byType(SchedulePage), findsOneWidget);    // Verify if SchedulePage is visible again
    });
  });
}