import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ionicons/ionicons.dart';
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
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Ionicons.cart_outline, size: 30, color: Colors.grey),
              ),
            ],
            leading: const Icon(Icons.search, size: 30, color: Colors.grey),
            title: const SizedBox(
              width: 200,
              child: Column(
                children: [
                  Text(
                    "Make home ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                        fontFamily: "Merriweather"),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "BEAUTIFUL",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Gelasio",
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
            SizedBox(height: 10.h,),
               SizedBox(height: 60.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: ShapeDecoration(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                            ),
                                child: const Center(
                                  child: Icon(Icons.star,color: Colors.white,),
                                ),
                                              ),
                              const Text(
                                "Popular ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                    fontFamily: "Merriweather"),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: ShapeDecoration(
                                  color: AppColors.greylight,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.chair,color: AppColors.darkGrey),
                                ),
                              ),
                              const Text(
                                "Chair ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                    fontFamily: "Merriweather"),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: ShapeDecoration(
                                  color: AppColors.greylight,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.table_bar_outlined,color: AppColors.darkGrey),
                                ),
                              ),
                              const Text(
                                "Table ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                    fontFamily: "Merriweather"),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: ShapeDecoration(
                                  color: AppColors.greylight,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.chair_outlined,color: AppColors.darkGrey),
                                ),
                              ),
                              const Text(
                                "Sofa ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                    fontFamily: "Merriweather"),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: ShapeDecoration(
                                  color: AppColors.greylight,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.bed_outlined,color: AppColors.darkGrey),
                                ),
                              ),
                              const Text(
                                "Bed ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                    fontFamily: "Merriweather"),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: ShapeDecoration(
                                  color: AppColors.greylight,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Iconsax.lamp_1_copy,color: AppColors.darkGrey),
                                ),
                              ),
                              const Text(
                                "Lamb ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                    fontFamily: "Merriweather"),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ]
                                ),
                ))),
                                Expanded(
                                  child: Center(
                  child: FutureBuilder<List<Item>>(
                    future:  dashboardController.generateRandomItems(10),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No data available.');
                      } else {
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ItemCard(cardinfo: snapshot.data![index]);
                          },
                        );
                      }
                    },
                  ),
                                  ),
                                ),
                              ],
                            ),),

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
