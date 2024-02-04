import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final DashboardController dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    var media =MediaQuery.of(context).size;
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body:

          Center(
            child: CircularProgressIndicator(strokeWidth: 1,
              backgroundColor: Colors.white,
              color: Colors.grey.withOpacity(.5),),
          )
        ),
        onWillPop: () async {
          bool exit = await showModalBottomSheet(
            context: context,
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp),
              ),
            ),
            builder: (context) => Container(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Exit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(color: AppColors.grey,thickness: .5.sp),
                  SizedBox(height: 8.h),
                  Text(
                    'Are you sure you want to Exit?',
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(335.w, 48.w),
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child:  Text(
                          'Yes, Exit',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(335.w, 48.w),
                          backgroundColor: AppColors.grey,
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child:  Text(
                          'No, Cancel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
          return exit;
        }
    );
  }
}
