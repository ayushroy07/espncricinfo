import 'package:flutter/material.dart';
import 'package:espncricinfo/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ESPN CricInfo',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: const SplashScreen(),
    ),
  );
}
