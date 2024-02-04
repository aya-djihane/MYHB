import'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhb_app/appColors.dart';
enum TypeText {title, subTitle, text,text3,text4, text5,text6,subtext,subsubtext,subsubtext2,appbartext,appbartext2,ckliked,text2,bottonText,introtitle, smallTest}
class CustomText extends StatelessWidget {
  final String value;
  final TypeText type;
  final Color? color;
  final double spaceBetween;
  final bool isClicked;
  final Function()? onTap;
  final bool uppercase;
  final bool underline;
  final bool newtext;
  final bool centered;
  final String family;

  const CustomText({

    this.newtext=false,
    Key? key,
    this.family='Roboto',
    this.uppercase=false,
    required this.value,
    required this.type,
    this.underline=false,
    this.spaceBetween = 0.0,
    this.color = AppColors.primaryGreen,
    this.isClicked = false,
    this.onTap,
    this.centered = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var fontWeight =  FontWeight.bold;
    var fontSize =  36.0.sp;
    switch(type){
      case TypeText.title:
        fontWeight = FontWeight.w400
        ;
        fontSize = 30.0.sp;
        break;
      case TypeText.subTitle:
        fontWeight = FontWeight.w900;
        fontSize = 25.0.sp;
        break;
      case TypeText.ckliked:
        fontWeight = FontWeight.w400;
        fontSize = 18.0.sp;
        break;
      case TypeText.text:
        fontWeight = FontWeight.w400;
        fontSize = 16.0.sp;
        break;
      case TypeText.subtext:
        fontWeight= FontWeight.w400;
        fontSize=13.sp;
        break;
      case TypeText.subsubtext:
        fontWeight= FontWeight.w400;
        fontSize=12.5.sp ;
        break;
      case TypeText.subsubtext2:
        fontWeight= FontWeight.w400;
        fontSize=12.sp ;
        break;
      case TypeText.appbartext:
        fontWeight=FontWeight.w400;
        fontSize=12.sp;
        break;
      case TypeText.appbartext2:
        fontWeight=FontWeight.w400;
        fontSize=11.sp;
        break;
      case TypeText.text2:
        fontWeight=FontWeight.w500;
        fontSize=14.sp;
        break;
      case TypeText.text3:
        fontWeight=FontWeight.w400;
        fontSize=14.sp;
        break;
      case TypeText.text4:
        fontWeight = FontWeight.w700;
        fontSize = 16.0.sp;
        break;
      case TypeText.text5:
        fontWeight=FontWeight.w600;
        fontSize=14.sp;
        break;
      case TypeText.text6:
        fontWeight = FontWeight.w500;
        fontSize = 16.0.sp;
        break;
      case TypeText.bottonText:
        fontWeight=FontWeight.w500;
        fontSize=12.sp;
        break;
      case TypeText.introtitle:
        fontWeight=FontWeight.w600;
        fontSize=20.sp;
        break;
      case TypeText.smallTest:
        fontWeight=FontWeight.w400;
        fontSize=10.sp;
        break;
    }
    return  DefaultTextStyle(
      style: TextStyle(
        decoration:underline? TextDecoration.underline:TextDecoration.none,
        letterSpacing:spaceBetween ,
        fontWeight:fontWeight,
        fontFamily: family,
        fontSize: fontSize,
        color: color,
      ),
      textAlign: centered ? TextAlign.center : TextAlign.justify,
      child: isClicked ? GestureDetector(
        onTap: onTap,
        child: Text(uppercase?
        value.toUpperCase():value),
      ) : Text(uppercase?
      value.toUpperCase():value),
    );

  }
}
