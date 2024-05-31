import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/controller/account_controller.dart';
import 'package:myhb_app/screens/Privacy&Terms.dart';
import 'package:myhb_app/screens/faq_screen.dart';
import 'package:myhb_app/screens/messageScreen.dart';
import '../appColors.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    String USER_COLLECTON_REF="users";
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.yellow
                  : AppColors.yellow,
            ),
          ),
        ),
        title: SizedBox(
          width: 200,
          child: Text(
            "Setting ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.black
                  : AppColors.yellow,
              fontFamily: "Merriweather",
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: GetBuilder<AccountController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Theme.of(context).brightness ==
                          Brightness.light
                          ? AppColors.darkGreyDark
                          : AppColors.yellow,
                      fontWeight: FontWeight.w900),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        nameController.text =
                            controller.currentUser.value!.name!;
                        emailController.text =
                            controller.currentUser.value!.email!;
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Edit Information'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Name'),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: ()async {
                                    await FirebaseFirestore.instance
                                        .collection(USER_COLLECTON_REF)
                                        .doc(controller.currentUser.value!.id)
                                        .update({
                                      'name': nameController.text,
                                    });
controller.fetchUsersAndCheckEmail();
                                  Get.back();
                                },
                                child: const Text('Save'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(Ionicons.pencil,
                          color: AppColors.darkGrey),
                    ),
                    Container(
                      height: 2,
                      width: 20,
                      color: AppColors.darkGrey,
                    )
                  ],
                )
              ],
            ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            height: 80.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color:Theme.of(context).brightness == Brightness.light
                                  ? AppColors.white
                                  : AppColors.lightBlack,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? Colors.black.withOpacity(.1):AppColors.grey.withOpacity(.2),
                                  blurRadius: 2,
                                  offset: const Offset(5, 5),
                                ),
                              ],
                            ),

                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text("Name",style:  TextStyle(fontFamily: 'Nunito',fontSize: 16,color: Theme.of(context).brightness == Brightness.light
                                      ? AppColors.darkGreyDark
                                      : AppColors.white,fontWeight:FontWeight.w700 ),),
                                  Text("${controller.currentUser.value!.name}",style:  TextStyle(fontFamily: 'Nunito',fontSize: 16,color: Theme.of(context).brightness == Brightness.light
                                      ? AppColors.black
                                      : AppColors.yellow,fontWeight:FontWeight.w700 ),),

                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            height: 80.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color:Theme.of(context).brightness == Brightness.light
                                  ? AppColors.white
                                  : AppColors.lightBlack,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? Colors.black.withOpacity(.1):AppColors.grey.withOpacity(.2),
                                  blurRadius: 2,
                                  offset: const Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text("Email",style:  TextStyle(fontFamily: 'Nunito',fontSize: 16,color: Theme.of(context).brightness == Brightness.light
                                      ? AppColors.darkGreyDark
                                      : AppColors.white,fontWeight:FontWeight.w700 ),),
                                  Text("${controller.currentUser.value!.email}",style:  TextStyle(fontFamily: 'Nunito',fontSize: 16,color: Theme.of(context).brightness == Brightness.light
                                      ? AppColors.black
                                      : AppColors.yellow,fontWeight:FontWeight.w700 ),),

                                ],
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                                    "Help Center",
                                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Theme.of(context).brightness ==
                          Brightness.light
                          ? AppColors.darkGreyDark
                          : AppColors.yellow,
                      fontWeight: FontWeight.w900),
                                  ),
                  ),
                        Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: (){Get.to(FAQScreen());},
                  child: Container(
                    height: 64.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color:Theme.of(context).brightness == Brightness.light
                          ? AppColors.white
                          : AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black.withOpacity(.1):AppColors.grey.withOpacity(.2),
                          blurRadius: 2,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("FAQ",style:  TextStyle(fontFamily: 'Nunito',fontSize: 16,color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.black
                              : AppColors.white,fontWeight:FontWeight.bold ),),
                       Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppColors.black
                                  : AppColors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                        Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: (){Get.bottomSheet(SendMessageScreen());},
                  child: Container(
                    height: 64.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color:Theme.of(context).brightness == Brightness.light
                          ? AppColors.white
                          : AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black.withOpacity(.1):AppColors.grey.withOpacity(.2),
                          blurRadius: 2,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Contect Us",style:  TextStyle(fontFamily: 'Nunito',fontSize: 16,color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.black
                              : AppColors.white,fontWeight:FontWeight.bold ),),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppColors.black
                                  : AppColors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),

                ),
              ),  Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: (){Get.to(PrivacyTermsScreen());},
                  child: Container(
                    height: 64.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color:Theme.of(context).brightness == Brightness.light
                          ? AppColors.white
                          : AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black.withOpacity(.1):AppColors.grey.withOpacity(.2),
                          blurRadius: 2,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Privacy & Terms",style:  TextStyle(fontFamily: 'Nunito',fontSize: 16,color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.black
                              : AppColors.white,fontWeight:FontWeight.bold ),),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppColors.black
                                  : AppColors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),

                ),
              ),
                      ],

                    ),)
          ]
                ),



            ),
          );
        },
      ),
    );
  }
}
