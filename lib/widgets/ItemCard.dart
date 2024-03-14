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
          color: AppColors.white,
          boxShadow:  [
            BoxShadow(
              color: AppColors.grey.withOpacity(.3),
              blurRadius: 10,
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
                  height: 100.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: ModelViewer(
                    backgroundColor: Colors.transparent,
                    loading:Loading.auto ,
                    src: '${widget.cardinfo.file}',
                    alt: 'A 3D model of an astronaut',
                    ar: false,
                    autoRotate: false,
                    iosSrc: '${widget.cardinfo.file}',
                    disableZoom: true,
                    maxFieldOfView: '100deg',
                    minFieldOfView: '50deg',
                    cameraOrbit: '0deg 0deg 0.5m',
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.only(left: 15.0),
                 child: Text(widget.cardinfo.name??"",style: const TextStyle(fontFamily: "Nunito",color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
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
