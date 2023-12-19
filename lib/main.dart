import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/loginscreen.dart';


void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }

}


