import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import the GetX package
import 'screens/splash_screen.dart';
// Import your bindings file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      home: SplashScreen(),
    );
  }
}
