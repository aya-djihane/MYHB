import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myhb_app/screens/dashbord.dart';
import 'package:myhb_app/widgets/custom_button.dart';
import '../appColors.dart';
class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:   Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
           const Text("SUCCESS!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36,fontFamily: 'Merriweather'),),
            SizedBox(
              height: 60.h,
            ),
            SizedBox(
              height: 200,
              child: SvgPicture.asset("images/Group.svg" ,color: AppColors.golden,),
            ),
            SizedBox(
              height: 20.h,
            ),
             const SizedBox(
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 20.0),
                   child: Text(" We will contact you  soo soon ! and Your order will be delivered soon .Thank you for choosing our app!!",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16,fontFamily: 'Nunito'),),
                 )),
            SizedBox(height: 60.h,),
            CustomButton(width: 315.w,onTap: (){
              Get.off(const UserDashboard());
            }, value: "Back To home",color: AppColors.golden,)
          ]
      ),
    );
  }
}
