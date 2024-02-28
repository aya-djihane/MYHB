import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      child: SizedBox(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.cardinfo.image!), // Fixed Image.network usage
                      fit: BoxFit.fill, // Added BoxFit.cover for better image display
                    ),
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.only(left: 15.0),
                 child: Text(widget.cardinfo.name??"",style: const TextStyle(fontFamily: "Nunito",fontSize: 14,fontWeight: FontWeight.w500),),
               ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(widget.cardinfo.price??"",style: const TextStyle(fontFamily: "Nunito",color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w900),),
      ),
              ],
            ),
            Positioned(
              bottom: 70,
              right: 20,
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.grey,
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
