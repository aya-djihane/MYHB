import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/widgets/custom_button.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatefulWidget {
  final Item cardinfo;
  const ProductDetails({required this.cardinfo,super.key});
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Align(
              alignment: Alignment.topRight,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-60,
                    height: MediaQuery.of(context).size.height/2,
                    decoration:  BoxDecoration(
                   color: AppColors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                        boxShadow:  [
                          BoxShadow(
                              color: AppColors.black.withOpacity(.1),
                              blurRadius: 2,
                              offset: const Offset(5,5)
                          )
                        ]
                    ),

                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    child:SizedBox(
                      width:250 ,
                    height: 250,
                    child: Image.network(widget.cardinfo.image!),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child:GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                      width: 50,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: AppColors.greylight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  const Padding(
                        padding: EdgeInsets.all(5.0),
                      child: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.darkGrey,size: 20,),
                      ),
                                        ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    child:Container(
                      decoration: ShapeDecoration(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          shadows:  [
                            BoxShadow(
                                color: AppColors.black.withOpacity(.1),
                                blurRadius: 2,
                                offset: const Offset(-2, 2)
                            )
                          ]
                      ),
                      child:  Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: ShapeDecoration(
                                color: AppColors.primaryGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: ShapeDecoration(
                                color: AppColors.golden,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: ShapeDecoration(
                                color: AppColors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ),
                ],
              ),
            ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                widget.cardinfo.name!,
                    style: const TextStyle(
                      fontFamily: "Gelasio",
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff303030),
                      height: 30/24,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      children: [
                        const Icon(Icons.star,color: Colors.yellow,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.cardinfo.rate.toString(),
                            style: const TextStyle(
                              fontFamily: "Nunito Sans",
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                    const Text(
  "(50 reviews)",
                      style: TextStyle(
                        fontFamily: "Nunito Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff606060),
                      ),
                      textAlign: TextAlign.justify,
                    )
                  ],),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      widget.cardinfo.price!,
                      style: const TextStyle(
                        fontFamily: "Nunito Sans",
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff303030),
                        height: 41/30,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
              ReadMoreText(
                widget.cardinfo.description!,
                trimLines: 5,
                colorClickableText: AppColors.darkGrey,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: const TextStyle(
                  fontFamily: "Nunito Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff606060),
                ), ),

                ],
              ),
            ),
          ),


        ],
      ),
    floatingActionButton: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          const SizedBox(width: 20,),
          Container(
            width: 50,
            height: 50,
            decoration: ShapeDecoration(
              color: AppColors.greylight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:  Padding(
              padding: const EdgeInsets.all(3.0),
              child: SizedBox(height: 90, width: 90, child: Image.asset("images/augmentedreality.png", color: AppColors.black)),
            ),
          ),

          const SizedBox(width: 20,),
          CustomButton(width: 225, value: "Add to cart",color: AppColors.darkGrey,)
        ],
      ),
    ),
    );
  }
}