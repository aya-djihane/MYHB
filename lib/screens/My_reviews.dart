import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/controller/account_controller.dart';
import 'package:myhb_app/screens/product_details.dart';
import 'package:readmore/readmore.dart';
import '../appColors.dart';
class MyReviews extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget buildStarRating(int rating,) {
      List<Widget> stars = [];
      for (int i = 0; i < rating; i++) {
        stars.add(const Icon(Icons.star, color: AppColors.yellowDark,size: 20,));
      }
      return Row(children: stars);
    }
    return Scaffold(
      appBar: AppBar(
        leading:  GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Icon(Icons.arrow_back_ios, size: 30, color: Theme.of(context).brightness == Brightness.light
                ? AppColors.yellow
                : AppColors.yellow,),
          ),
        ),
        title:  SizedBox(
          width: 200,
          child: Text(
            "My reviews ",
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
          controller.fetchItems() ;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:
                    Obx(() => Column(
                      children: controller.selectedreviews.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: GestureDetector(
                            onTap: (){
                              Get.to(ProductDetails(cardinfo: item.item!,));
                            },
                            child: Container(
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
                                                     height: 150.h,
                              child:   Padding(
                                padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                    Row(
                                      children: [
                                        Container(height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),

                                  ),
                                  width: 70,
                                   child:ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                     child: Image.network(
                                       item.item!.image!,
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                        ),
                                    const SizedBox(width: 10,),
                                        SizedBox(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${item.item!.name}"),
                                            Text("${item.item!.price}    DZ",style:  TextStyle(color:Theme.of(context).brightness == Brightness.light
                                                ? AppColors.darkGrey:AppColors.white,fontSize: 16,fontWeight: FontWeight.w900)),
                                          ],
                                        ),)
                                      ],
                                    ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          buildStarRating(item.rating!),
                                          Text("${item.date}",style:TextStyle(color:Theme.of(context).brightness == Brightness.light ? AppColors.darkGrey:AppColors.white,fontSize: 16,fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      ReadMoreText(
                                        item.review ?? "",
                                        trimLines: 1,
                                        colorClickableText: Theme.of(context).brightness == Brightness.light ? AppColors.darkGrey:AppColors.yellow,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: ' Show more',
                                        trimExpandedText: ' Show less',
                                        lessStyle: TextStyle(
                                          fontFamily: "Nunito Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Theme.of(context).brightness == Brightness.light
                                              ? AppColors.darkGrey:AppColors.white,
                                        ) ,
                                        moreStyle:  TextStyle(
                                          fontFamily: "Nunito Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Theme.of(context).brightness == Brightness.light
                                              ? AppColors.darkGrey:AppColors.white,
                                        ),
                                      ),
                                  ],),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                    ),)
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
