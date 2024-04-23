import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/models/review.dart';
import 'package:myhb_app/widgets/camerascreen.dart';
import 'package:myhb_app/widgets/costumformfield.dart';
import 'package:myhb_app/widgets/custom_button.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatefulWidget {
  final Item cardinfo;
  const ProductDetails({required this.cardinfo, Key? key}) : super(key: key);
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}
class _ProductDetailsState extends State<ProductDetails> {
  final ItemController controller = Get.find();
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    controller.isfavorate.value = widget.cardinfo.isfavorite!;
      controller.chooseitem(widget.cardinfo.id!);
  }

  @override
  Widget build(BuildContext context) {
    var media= MediaQuery.of(context).size;
    return GetX<ItemController>(
        init: controller,
        builder: (controller) {
         return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:  Text(
            "${widget.cardinfo.name??"Item"} details" ?? "",
            style: const TextStyle(
              fontFamily: "Gelasio",
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Color(0xff494646),
              height: 30 / 24,
            ),
            textAlign: TextAlign.left,
          ),
          backgroundColor: AppColors.white,
          leading:
          Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 8,bottom: 8),
            child: GestureDetector(
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
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(.1),
                            blurRadius: 2,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 2.05,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController, // Set the controller here
                        itemCount: widget.cardinfo.files!.length,
                        onPageChanged: (index) {
                          controller.choosenItem.value = index;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              height: MediaQuery.of(context).size.height / 2.3,
                              child: ModelViewer(
                                backgroundColor: Colors.transparent,
                                src: widget.cardinfo.files![index],
                                alt: 'A 3D model of an astronaut',
                                ar: false,
                                autoRotate: true,
                                iosSrc: widget.cardinfo.files![index],
                                disableZoom: false,
                                maxFieldOfView: '50deg',
                                minFieldOfView: '60deg',
                                cameraOrbit: '42deg 90deg 0.5m',
                              ),
                            ),
                          );
                        },
                      ),

                    ),
                    Positioned(
                      top: 140,
                      child: Container(
                        decoration: ShapeDecoration(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          shadows: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(.2),
                              blurRadius: 2,
                              offset: const Offset(-2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: widget.cardinfo.colors!.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final String item = entry.value;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  controller.choosenItem.value = index;
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: Color(int.parse("0xFF$item")),
                                      borderRadius: BorderRadius.circular(50),
                                      // border: Border.all(color: Colors.black),
                                      boxShadow:[
                                        BoxShadow(
                                          color: AppColors.black.withOpacity(.5),
                                          blurRadius: 2,
                                          offset: const Offset(-1, 2),
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 70,top: 20,left: 20,right: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cardinfo.name ?? "",
                        style: const TextStyle(
                          fontFamily: "Gelasio",
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff303030),
                          height: 30 / 24,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow),
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "${widget.cardinfo.price} DA" ?? "",
                          style: const TextStyle(
                            fontFamily: "Nunito Sans",
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff303030),
                            height: 41 / 30,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ReadMoreText(
                        widget.cardinfo.description ?? "",
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Reviews",
                        style: TextStyle(
                          fontFamily: "Nunito Sans",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: controller.selectedreviews.value.map((review) => Column(
                          children: [
                            Container(
                                color: Colors.white,
                                child: Center(child: Text(review.user!.profil!,))),
                            Text(review.review ?? ""),
                          ],
                        )).toList(),
                      ),

                      CustomButton(width: media.width, value: "Add Review",color: AppColors.darkGrey,onTap: (){
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.greylight,
                                content: Container(
                                  width: 310.w,
                                  height: 320.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .circular(3)),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            SizedBox(
                                              width: 99.w,
                                              height: 18.h,
                                              child: const Text(
                                                'Review',
                                                style: TextStyle(
                                                  color: Color(
                                                      0xFF1A1818),
                                                  fontSize: 16,
                                                  fontFamily: 'Calibri',
                                                  fontWeight: FontWeight
                                                      .w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: 36.w,
                                                height: 30.h,
                                                decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(
                                                    side: BorderSide(
                                                        width: 0.50,
                                                        color: Color(
                                                            0xFFE5E5E5)),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 20,),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 70,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      widget.cardinfo.image!),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: const OvalBorder(),
                                              ),
                                            ),

                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            const Text(
                                              'Rate to Item',
                                              style: TextStyle(
                                                color: Color(0xFF1A1818),
                                                fontSize: 14,
                                                fontFamily: 'Calibri',
                                                fontWeight: FontWeight
                                                    .w400,
                                                height: 0,
                                              ),
                                            ),
                                            // **********
                                            RatingBar.builder(
                                              initialRating: 1,
                                              glowColor: AppColors.white,
                                              unratedColor: AppColors.darkGrey
                                                  .withOpacity(.4),
                                              itemSize: 35,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: AppColors
                                                    .darkGrey,
                                              ),
                                              onRatingUpdate: (rating) {
                                                controller.reviewInt
                                                    .value =
                                                    rating.toInt();
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            const SizedBox(
                                              width: 84,
                                              height: 18,
                                              child: Text(
                                                'Rate the Item',
                                                style: TextStyle(
                                                  color: Color(
                                                      0xFF1A1818),
                                                  fontSize: 14,
                                                  fontFamily: 'Calibri',
                                                  fontWeight: FontWeight
                                                      .w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            CustomFormMultiline(
                                              hintText: 'Write here',
                                              labelText: '',
                                              textSize: 10,
                                              isTextArea: true,
                                              onChange: (value) {
                                                controller.message.value =
                                                    value;
                                              },),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: CustomButton(
                                            onTap: () {
                                              controller.addreview(widget.cardinfo);
                                              Navigator.pop(context);
                                              // controller.detectReview();
                                            },
                                            color: AppColors.darkGrey,
                                            width: 310.w, value: 'SUBMIT',),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 50),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Center(
                            child: CameraScreen(file: widget.cardinfo.files![controller.choosenItem.value])),
                      ),
                    ),
                  );
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
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                        height: 90,
                        width: 90,
                        child: Image.asset("images/augmentedreality.png",
                            color: AppColors.darkGrey)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CustomButton(
                  width: 180, value: "Add to cart", color: AppColors.darkGrey),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  controller.isfavorate.value = !controller.isfavorate.value;
                  controller.updateRecode(
                    Item(
                      price: widget.cardinfo.price,
                      image: widget.cardinfo.image,
                      rate: widget.cardinfo.rate,
                      id: widget.cardinfo.id,
                      type: widget.cardinfo.type,
                      description: widget.cardinfo.description,
                      isfavorite: controller.isfavorate.value,
                      name: widget.cardinfo.name,
                      colors: widget.cardinfo.colors,
                      files: widget.cardinfo.files,
                    ),
                  );
                },
                child: Obx(() => Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: AppColors.greylight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                        height: 90,
                        width: 90,
                        child: SvgPicture.asset("images/heart.svg",
                            color: controller.isfavorate.value
                                ? Colors.red
                                : AppColors.darkGrey)),
                  ),
                )),
              ),
            ],
          ),
        ),
      );
        });
  }
}
