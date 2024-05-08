import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/models/cart_item.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/screens/product_details.dart';

import '../service/database_service.dart';

class CartCard extends StatefulWidget {
  final CartItem cartItem;

  const CartCard({required this.cartItem, Key? key}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final ItemController  controller = Get.put(ItemController());
  int _counter=1;
  @override
  void initState() {
    _counter = widget.cartItem.counter;
    super.initState();
  }
  void _incrementCounter() {
    setState(() {
      _counter += 1;
      controller.updateCounter( widget.cartItem.item, _counter);
    });
  }
  void _decrementCounter() {
    setState(() {
      _counter -= 1;
      controller.updateCounter( widget.cartItem.item, _counter);
    });
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(ProductDetails(cardinfo: widget.cartItem.item));
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
                          image: NetworkImage(widget.cartItem.item.image!),
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
                            widget.cartItem.item.name??"",
                            style:  TextStyle(fontFamily: "Nunito", color: Theme.of(context).brightness == Brightness.light
                                ? AppColors.yellow : AppColors.white, fontSize: 18,fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 5),
                          Text("DZ ${  widget.cartItem.item.price!}",style:  TextStyle(color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.yellow
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
          top: 20.w,right: 0.w,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                 width: 25,
                height: 25,
                decoration: BoxDecoration(
    color: Theme.of(context).brightness == Brightness.light
    ? AppColors.yellow // Use light mode color
        : AppColors.lightBlack,
    borderRadius: const BorderRadius.all(Radius.circular(50)),
              )
                  ,child: const Center(
                child: Icon(Icons.close,color: AppColors.white,),
              ),
            ),
          ),
        )),
        Positioned(
          bottom: 20,left: 100.w,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: _incrementCounter,
                      child: const Text(' + ' , style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),)),
                  const SizedBox(width: 20,),
                  Container(
                   decoration: BoxDecoration(
                     color: AppColors.golden,
                     borderRadius: BorderRadius.circular(10)
                   ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                      child: Text(
                        '$_counter',
                        style: const TextStyle(fontSize: 12,color: AppColors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  GestureDetector(
                      onTap: _decrementCounter,
                      child: const Text(' - ' , style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),)),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
