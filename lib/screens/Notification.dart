import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/widgets/cartcard.dart';
import '../appColors.dart';
class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  SizedBox(
          child: Text(
            "Notifiactions ",
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
          controller.getnotification() ;
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
                              children: controller.notification.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 95.h,
                                    child: Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 60.h,
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                color: AppColors.black,
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: item.image.isEmpty
                                                ? const AssetImage("images/ic_luncher.jpg")
                                                      : NetworkImage(item.image) as ImageProvider<Object>,
                                          fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(" ${item.title}",style: const TextStyle(fontWeight: FontWeight.bold),),
                                                SizedBox(
                                                    width: MediaQuery.of(context).size.width-140.w,
                                                    child: Text(" ${item.subtitle}")),
                                              ],
                                            ),
                                          ],
                                        ),
                                        item.isreded==0? const Positioned(
                                          right: 20,
                                          bottom: 10,
                                          child: Text("New",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w900),),):SizedBox()
                                      ],

                                    ),
                                  ),
                                );
                              }).toList(),
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
