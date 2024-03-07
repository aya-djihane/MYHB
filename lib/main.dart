import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/service/database_service.dart';
import 'screens/noInternet_screen.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  DatabaseService().initNotifications();
  FirebaseFirestore.instance.settings= const Settings(
    persistenceEnabled: true
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        builder: (context, child) =>GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectivityWrapper(),
    )
    );
  }
}
class ConnectivityWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final hasConnection = snapshot.data != ConnectivityResult.none;

        return hasConnection ? const SplashScreen() : const NoInternetScreen();
      },
    );
  }
}
