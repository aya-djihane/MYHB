import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/screens/product_details.dart';

class ItemCard extends StatefulWidget {
  final Item cardinfo;

  ItemCard({required this.cardinfo, Key? key}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
Get.to(ProductDetails(cardinfo: widget.cardinfo,));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.white
              : AppColors.lightBlack,
          boxShadow:  [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ?AppColors.grey.withOpacity(.3)
                  : AppColors.lightBlack,
              blurRadius:  Theme.of(context).brightness == Brightness.light
                  ?10:2,
              offset: const Offset(4.5,5)
            )
          ]
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 99.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.cardinfo.image!),
                      fit: BoxFit.fill,
                    ),
                  ),

                ),
               Padding(
                 padding: const EdgeInsets.only(left: 15.0,top: 2),
                 child: Text(widget.cardinfo.name??"",style:  TextStyle(fontFamily: "Nunito",color: Theme.of(context).brightness == Brightness.light
                     ? AppColors.grey:AppColors.white,fontSize: 14,fontWeight: FontWeight.w700),),
               ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,bottom: 0),
                  child: Text(  "${widget.cardinfo.price} DA"??"",style:  TextStyle(fontFamily: "Nunito",color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.black
                      : AppColors.yellow,fontSize: 14,fontWeight: FontWeight.w900),),
      ),
              ],
            ),
            Positioned(
              bottom: 50,
              right: 10,
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.grey
                    : AppColors.yellow.withOpacity(0.8)
                ),
                child: const Center(
                  child: Icon(Icons.shopping_bag, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
