//-- needs improvement on the back function of the search bar
//-- needs improvement on the UI of the floor plan (make it a "window" like before)

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:up_classroom_finder_ay2324_cs192/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/classroomdetail_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/map_image.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/map_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/notes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'UP CLASSROOM FINDER',
        theme: ThemeData(
          primaryColor: Color(0xFF8C0000), //Maroon

          primarySwatch: MaterialColor(
            0xFF8C0000,
            <int, Color>{
              50: Color(0xFFF8E0E0),
              100: Color(0xFFF1C1C1),
              200: Color(0xFFE9A1A1),
              300: Color(0xFFE28282),
              400: Color(0xFFDB6262),
              500: Color(0xFFD44242),
              600: Color(0xFF8C0000),
              700: Color(0xFF8C0000),
              800: Color(0xFF8C0000),
              900: Color(0xFF8C0000),
            },
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MapPage(),
      ),
    );
  }
}
