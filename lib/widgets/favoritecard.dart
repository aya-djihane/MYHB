import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/screens/product_details.dart';

class FavoriteCard extends StatefulWidget {
  final Item cardinfo;

  const FavoriteCard({required this.cardinfo, Key? key}) : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  final ItemController  controller = Get.put(ItemController());
  final DashboardController dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(ProductDetails(cardinfo: widget.cardinfo));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Container(
              width: media.width,
              decoration:  BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
    ? AppColors.white // Use light mode color
        : AppColors.lightBlack,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(color: AppColors.darkGrey.withOpacity(.4),blurRadius: 5,offset: const Offset(-4, 3)),
                ],
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
                            widget.cardinfo.name??"",
                            style:  TextStyle(fontFamily: "Nunito", color: Theme.of(context).brightness == Brightness.light
                                ? AppColors.black
                                : AppColors.yellow, fontSize: 18,fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 5),
                          Text(
                           "DZ ${ widget.cardinfo.price!}",
                            style:  TextStyle(color: Theme.of(context).brightness == Brightness.light
                                ? AppColors.black
                                : AppColors.yellow, fontSize: 15, fontWeight: FontWeight.bold),
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
          right: 3,
          child: GestureDetector(
            onTap: ()async{
              dashboardController.loadingFavorite.value=false;
              await controller.updateRecode(Item(
                  price: widget.cardinfo.price,
                  image: widget.cardinfo.image,
                  rate:widget.cardinfo.rate,
                  id:widget.cardinfo.id,
                  type: widget.cardinfo.type,
                  description: widget.cardinfo.description,
                  isfavorite: false,
                  name: widget.cardinfo.name,
                  files: widget.cardinfo.files,
                  colors: widget.cardinfo.colors
              ));
              dashboardController.fetchFavoriteItems() ;
            },
            child: Container(
              width: 28,
              height: 28,
              decoration:  BoxDecoration(
                  color: Colors.red.withOpacity(0.5),
                  border: Border.all(color: AppColors.darkGrey,width: 1),
                  borderRadius: BorderRadius.circular(50)
              ),
              child:const Center(
                child: Icon(
                    Icons.close, size: 20, color: Colors.black
                ),
              ),),
          ),
        ),
        Positioned(
        bottom: 20,right: 30,
          child: Container(
            width: 120,
            height: 28,
            decoration:  BoxDecoration(
                color: AppColors.greylight,
                border: Border.all(color: AppColors.darkGrey,width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text("add to cart",style: TextStyle(fontSize: 12),),
                    SizedBox(width: 5,),
                    Icon(Icons.shopping_bag, size: 20,color: AppColors.black),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
