import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(124, 252, 0, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Welcome to the clothes shop",
              style: TextStyle(
                color: Color.fromRGBO(128, 0, 32, 1.0),
                fontSize: 46.0,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Lab2-201097",
              style: TextStyle(
                color: Color.fromRGBO(128, 0, 32, 1.0),
                fontSize: 34.0,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}