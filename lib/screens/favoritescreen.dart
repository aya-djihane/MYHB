import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/widgets/favoritecard.dart';
import '../appColors.dart';
import '../widgets/custom_button.dart';
class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Text(
            "Favorites ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
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
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: controller.favoriteItems.isEmpty?Column(
                              children: controller.favoriteItems.map((item) {
                                return FavoriteCard(cardinfo: item);
                              }).toList(),
                            ):
                              const Padding(
                              padding: EdgeInsets.only(top: 150.0),
                          child: Text('No favorites available yet'),
                        ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 55.w),
                          child: Center(
                            child: CustomButton(
                              width: MediaQuery.of(context).size.width.w / 1.45,
                              color: Colors.black,
                              value: 'Add to my cart',
                            ),
                          ),
                        ),
                      ),
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
