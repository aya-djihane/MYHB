import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  get fonts => null;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Column (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                 Container(width: media.width/3.1,height: 1,color: AppColors.grey,),
                  const SizedBox(
                    width: 10,
                  ),
                   SizedBox(height:90,width:90,child : SvgPicture.asset("svgfiles/login.svg",color: AppColors.black,)),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(width: media.width/3.1,height: 1,color: AppColors.grey,),
                ],
              ),
            ),
          )
          ,
        const Padding(
          padding: EdgeInsets.only(left: 30.0,top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color:AppColors.grey,
                ),
              ),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greydark,
                ),
              ),
            ],
          ),
        ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 30.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: AppColors.blacklight),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:AppColors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:AppColors.primaryGreen),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: AppColors.blacklight),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:AppColors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:AppColors.primaryGreen),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
    const Padding(
    padding: EdgeInsets.only(left: 90,top: 40),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'forgot password ?',
    style: TextStyle(
    fontSize: 16,
      fontFamily: "nunito",
    fontWeight: FontWeight.bold,
    color:AppColors.blacklight,)
    ),

  ]),
    ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 40),
              child: CustomButton(width: media.width, value: 'Log In'),
            ),
          ),
        ],
      ),
    );
  }
}
