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
            bottom: 100,
            left: media.width /3.7,
            child: CustomButton(
              onTap: ()=>Get.to(LoginScreen()),
              width: media.width / 2,
              value: "Get Started",
              color: AppColors.lightBlack,
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
                    fontSize: 25,
                    fontFamily: "Gelasio",
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey,
                  ),
                ),
                Text(
                  'HOME BEAUTIFUL',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gelasio",
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Text(
                    'The best simple place where you\n '
                        'discover most wonderful furnitures\n '
                        'and make your home beautiful. ',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "NunitoSans",
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),],
      ),
    );
  }
}
