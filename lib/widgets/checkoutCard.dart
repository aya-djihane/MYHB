import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/chekoutEntry.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/models/cart_item.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/screens/product_details.dart';

import '../service/database_service.dart';

class checkoutCard extends StatefulWidget {
  final CheckoutEntry cartItem;
  const checkoutCard({required this.cartItem, Key? key}) : super(key: key);
  @override
  State<checkoutCard> createState() => _checkoutCardState();
}
class _checkoutCardState extends State<checkoutCard> {
  final ItemController  controller = Get.put(ItemController());
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(ProductDetails(cardinfo: widget.cartItem.item.item));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: media.width,
              decoration:  BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.white
                    : AppColors.lightBlack,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(color: AppColors.darkGrey.withOpacity(.4),blurRadius: 5,offset: const Offset(-4, 3)),
                ],
              ),
              height: 124.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget.cartItem.item.item.image??"https://mega-tech.dev/PFE/Group.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Text(
                            widget.cartItem.item.item.name??"",
                            style:  TextStyle(fontFamily: "Nunito", color: Theme.of(context).brightness == Brightness.light
                                ? AppColors.yellow : AppColors.white, fontSize: 18,fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 5),
                          Text("DZ ${widget.cartItem.item.item.price??""} X${widget.cartItem.item.counter??""} ",style:  TextStyle(color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.black
                              : AppColors.white, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,right: 0.w,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.golden,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                      child: Text(
                        widget.cartItem.checkoutDate,
                        style: const TextStyle(fontSize: 12,color: AppColors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
