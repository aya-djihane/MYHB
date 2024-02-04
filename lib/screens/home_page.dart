import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/widgets/ItemCard.dart';
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
          appBar: AppBar(
            backgroundColor: AppColors.white,
            actions: const [Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Iconsax.shopping_cart_copy,size: 30,color: Colors.grey,),
            )],
            leading: const Icon(Icons.search,size: 30,color: Colors.grey,),
            title: SizedBox(
              width: 200,
              child: Column(
                children: [
              Text(
              "Make home ",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
color: AppColors.darkGrey,
                fontFamily: "Merriweather"
              ),
              textAlign: TextAlign.center,
                        ),
                  Text(
                    "BEAUTIFUL",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Gelasio"
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body:

          Center(
    child: Column(
      children: [
        ItemCard(cardinfo: Item(id: 0,image: "https://images.unsplash.com/photo-1540574163026-643ea20ade25?q=80&w=3870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",price: "5000DA"),),
        ItemCard(cardinfo: Item(id: 0,image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjaxtAloq7bYDMmMgiAcA93p7LZRKnI4-EoBuu5KTVFC9eXmsWa2Y4RdlbeACJmy7_b2c&usqp=CAU"
            "",price: "40000Da"),),
      ],
    ),
          //   child: CircularProgressIndicator(strokeWidth: 1,
          //     backgroundColor: Colors.white,
          //     color: Colors.grey.withOpacity(.5),),
          // )
        ),
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
                          backgroundColor: AppColors.lightblack,
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
