import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/app_controller.dart';
import 'package:myhb_app/service/database_service.dart';
import 'screens/dashbord.dart';
import 'screens/noInternet_screen.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('userToken');

  runApp(MyApp(isLoggedIn: userToken != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => ChangeNotifierProvider<UiProvider>(
        create: (context) => UiProvider(),
        child: Consumer<UiProvider>(
          builder: (context, uiProvider, _) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.yellow[700],
              drawerTheme: const DrawerThemeData(
                backgroundColor: Colors.black,
              ),
              brightness: uiProvider.isDark ? Brightness.dark : Brightness.light,
            ),
            home: isLoggedIn ? const UserDashboard() : ConnectivityWrapper(),
          ),
        ),
      ),
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
