import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/screens/loginscreen.dart';
import 'package:myhb_app/widgets/custom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: media.width,
            height: media.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/SplashBG.png"),
                fit: BoxFit.fill,
              ),
            ),

          ), Positioned(
            bottom: 30,
            left: media.width /3.7,
            child: CustomButton(
              onTap: ()=>Get.to(LoginScreen()),
              width: media.width / 2,
              value: "Get Started",
              color: AppColors.darkGrey,
            ),
          ),
          const Positioned(
            top: 200,
            left: 20,
            child:   Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make Your',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Merriweather",
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  'Make Your',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "RubikLines",
                    fontWeight: FontWeight.bold,
                    color: AppColors.greydark,
                  ),
                ),
                Text(
                  'Make Your ',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "RubikLines",
                    fontWeight: FontWeight.bold,
                    color: AppColors.greydark,
                  ),
                ),
              ],
            ),
          ),],
      ),
    );
  }
}
