import 'package:flutter/material.dart';
import 'activity/home_screen.dart';
import 'activity/loding_screen.dart';
void main() {
  runApp(MaterialApp(
 debugShowCheckedModeBanner: false,
    routes: {
      "/": (context)=>const LoadingScreen(),
      "/home": (context)=>const HomeScreen(),
      "/Loading":(context) =>const LoadingScreen()
    },
  ));
}


