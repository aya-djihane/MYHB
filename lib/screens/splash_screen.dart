import 'package:flutter/material.dart';
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
    var media= MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: media.width,
            height: media.height,
            decoration: const BoxDecoration(
                image:DecorationImage(image: AssetImage("images/SplashBG.png"),fit: BoxFit.fill

                )
            ),
          ),
         // att nchof andi nrml 2 min brQ mchi haja
          Positioned(
              bottom: 30,
              left: media.width/3,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: CustomButton(width: media.width/3,value: "Get Started"
                ,),
              ))
        ],
      ),
    );
  }
}