import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_classroom_finder_ay2324_cs192/firebase_options.dart';

import 'pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        home: const MapPage(),
      ),
    );
  }
}





