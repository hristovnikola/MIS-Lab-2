import 'package:flutter/material.dart';
import 'package:lab2_201097/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab2 - 201097',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(137,1,4,1.0)),
        useMaterial3: true,
      ),
      home: const Splashscreen(),
    );
  }
}