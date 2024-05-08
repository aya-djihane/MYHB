import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/widgets/cartcard.dart';
import 'package:myhb_app/widgets/custom_button.dart';
import 'package:myhb_app/widgets/favoritecard.dart';
import '../appColors.dart';
class cartScreen extends StatelessWidget {
  ItemController itemController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: CustomButton(width: MediaQuery.of(context).size.width, withOpacity: false,value: 'Check out',
        ),
      ),
      appBar: AppBar(
        title:  SizedBox(
          width: 200,
          child: Text(
            "My Orders ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.black // Use light mode color
                  : AppColors.yellow, // Use dark mode color
              fontFamily: "Merriweather",
            ),
            textAlign: TextAlign.center,
          ),
        ),

      ),
      body: GetBuilder<ItemController>(
        builder: (controller) {
          controller.fetchOrderItems() ;
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 70.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child:
                              Obx(() =>  Column(
                                children: [
                                  Column(
                                            children: controller.selectedItemscart.map((item) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CartCard(cartItem: item,),
                                            );
                                            }).toList(),

                                            ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Total"),
                                      Text("${controller.totalorder} DZ"),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),

                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
