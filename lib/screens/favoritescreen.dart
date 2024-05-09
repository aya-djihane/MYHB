import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/screens/cart_view.dart';
import 'package:myhb_app/widgets/favoritecard.dart';
import '../appColors.dart';
class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: (){

                Get.to(CartScreen());
              },
              child: Icon(Ionicons.cart_outline, size: 30, color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.yellow
                  : AppColors.yellow,),
            ),
          ),
        ],
        title:  SizedBox(
          width: 200,
          child: Text(
            "Favorites ",
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
      body: GetBuilder<DashboardController>(
        builder: (controller) {
          controller.fetchFavoriteItems() ;
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
                           Obx(() =>  controller.loadingFavorite.value?const Center(child:Padding(
                             padding: EdgeInsets.only(top: 150.0),
                             child: CircularProgressIndicator( ),
                           ),): controller.favoriteItems.isNotEmpty?Column(
                             children: controller.favoriteItems.map((item) {
                               return FavoriteCard(cardinfo: item);
                             }).toList(),
                           ):
                           const Center(
                             child: Padding(
                               padding: EdgeInsets.only(top: 150.0),
                               child: Text('No favorites available yet'),
                             ),
                           ),)
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 20,
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 55.w),
                      //     child: Center(
                      //       child: CustomButton(
                      //         width: MediaQuery.of(context).size.width.w / 1.45,
                      //         color: Colors.black,
                      //         value: 'Add to my cart',
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
