import 'package:flutter/material.dart';
import 'package:my_app/screens/home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roller Shutter Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: MainScreen(),
    );
  }
}
