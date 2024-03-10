import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/screens/product_details.dart';

class FavoriteCard extends StatefulWidget {
  final Item cardinfo;

  const FavoriteCard({required this.cardinfo, Key? key}) : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetails(cardinfo: widget.cardinfo));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Container(
          width: media.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: AppColors.darkGrey))
          ),
          height: 124,
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
                      image: NetworkImage(widget.cardinfo.image!),
                      fit: BoxFit.fill,
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
                        widget.cardinfo.name!,
                        style: const TextStyle(fontFamily: "Nunito", color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 5),
                      Text(
                       "DZ ${ widget.cardinfo.price!}",
                        style: const TextStyle( color: AppColors.black, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Container(
                      width: 28,
                      height: 28,
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.darkGrey,width: 1),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child:const Center(
                      child: Icon(
                          Icons.close, size: 20, color: Colors.black
                      ),
                    ),),
                    Container(
                      width: 28,
                      height: 28,
                      decoration:  BoxDecoration(
                      color: Colors.white,
                        border: Border.all(color: AppColors.darkGrey,width: 1),
                        borderRadius: BorderRadius.circular(50)
                    ),
                      child: const Center(
                        child: Icon(Icons.shopping_bag, size: 20,color: AppColors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
