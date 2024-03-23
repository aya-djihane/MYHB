// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:model_viewer_plus/model_viewer_plus.dart';
// import 'package:myhb_app/appColors.dart';
// import 'package:myhb_app/controller/item_controller.dart';
// import 'package:myhb_app/models/item.dart';
// import 'package:myhb_app/widgets/camerascreen.dart';
// import 'package:myhb_app/widgets/custom_button.dart';
// import 'package:readmore/readmore.dart';
//
// class ProductDetails extends StatefulWidget {
//   final Item cardinfo;
//   const ProductDetails({required this.cardinfo, Key? key}) : super(key: key);
//
//   @override
//   State<ProductDetails> createState() => _ProductDetailsState();
// }
//
// class _ProductDetailsState extends State<ProductDetails> {
//   final ItemController controller = Get.put(ItemController());
//   late PageController _pageController;
//
//   @override
//   void initState() {
//     controller.isfavorate.value = widget.cardinfo.isfavorite!;
//     _pageController = PageController(initialPage: controller.choosenItem.value);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: Stack(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width - 60,
//                     height: MediaQuery.of(context).size.height / 2,
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(50),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.black.withOpacity(.1),
//                           blurRadius: 2,
//                           offset: const Offset(5, 5),
//                         ),
//                       ],
//                     ),
//                   ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 1.4,
//                         height: MediaQuery.of(context).size.height / 2.3,
//                         child: PageView.builder(
//                           scrollDirection: Axis.horizontal,
//                           controller: _pageController,
//                           itemCount: widget.cardinfo.files!.length,
//                           onPageChanged: (index) {
//                             controller.choosenItem.value = index;
//                           },
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: PageView.builder(
//                                 controller: _pageController,
//                                 itemCount: widget.cardinfo.files!.length,
//                                 onPageChanged: (index) {
//                                   controller.choosenItem.value = index;
//                                 },
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return Positioned(
//                                     top: 50,
//                                     right: 20,
//                                     child: SizedBox(
//                                       width: 250,
//                                       height: 250,
//                                       child: ModelViewer(
//                                         backgroundColor: Colors.transparent,
//                                         src: widget.cardinfo.files![controller.choosenItem.value],
//                                         alt: 'A 3D model of an astronaut',
//                                         ar: false,
//                                         autoRotate: true,
//                                         iosSrc: widget.cardinfo.files![controller.choosenItem.value],
//                                         disableZoom: false,
//                                         maxFieldOfView: '50deg',
//                                         minFieldOfView: '50deg',
//                                         cameraOrbit: '0deg 0deg 0.5m',
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                   Positioned(
//                     top: 50,
//                     child: GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         width: 50,
//                         height: 50,
//                         decoration: ShapeDecoration(
//                           color: AppColors.greylight,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(5.0),
//                           child: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.darkGrey, size: 20),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 140,
//                     child: Container(
//                       decoration: ShapeDecoration(
//                         color: AppColors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         shadows: [
//                           BoxShadow(
//                             color: AppColors.black.withOpacity(.1),
//                             blurRadius: 2,
//                             offset: const Offset(-2, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: widget.cardinfo.colors!.map((item) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 int selectedIndex = widget.cardinfo.colors!.indexOf(item);
//                                 _pageController.animateToPage(
//                                   selectedIndex,
//                                   duration: const Duration(milliseconds: 500),
//                                   curve: Curves.easeInOut,
//                                 );
//                               },
//                               child: Container(
//                                 width: 25,
//                                 height: 25,
//                                 decoration: ShapeDecoration(
//                                   color: Color(int.parse("0xFF$item")),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.cardinfo.name ?? "",
//                       style: const TextStyle(
//                         fontFamily: "Gelasio",
//                         fontSize: 24,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff303030),
//                         height: 30 / 24,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(Icons.star, color: Colors.yellow),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 widget.cardinfo.rate.toString(),
//                                 style: const TextStyle(
//                                   fontFamily: "Nunito Sans",
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w900,
//                                   color: AppColors.black,
//                                 ),
//                                 textAlign: TextAlign.justify,
//                               ),
//                             )
//                           ],
//                         ),
//                         const Text(
//                           "(50 reviews)",
//                           style: TextStyle(
//                             fontFamily: "Nunito Sans",
//                             fontSize: 14,
//                             fontWeight: FontWeight.w300,
//                             color: Color(0xff606060),
//                           ),
//                           textAlign: TextAlign.justify,
//                         )
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text(
//                         widget.cardinfo.price ?? "",
//                         style: const TextStyle(
//                           fontFamily: "Nunito Sans",
//                           fontSize: 30,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff303030),
//                           height: 41 / 30,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     ReadMoreText(
//                       widget.cardinfo.description ?? "",
//                       trimLines: 5,
//                       colorClickableText: AppColors.darkGrey,
//                       trimMode: TrimMode.Line,
//                       trimCollapsedText: 'Show more',
//                       trimExpandedText: 'Show less',
//                       moreStyle: const TextStyle(
//                         fontFamily: "Nunito Sans",
//                         fontSize: 14,
//                         fontWeight: FontWeight.w300,
//                         color: Color(0xff606060),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Row(
//           children: [
//             const SizedBox(width: 20),
//             GestureDetector(
//               onTap: () {
//                 Get.dialog(
//                   Padding(
//                     padding: const EdgeInsets.only(top: 50.0, bottom: 50),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: const BoxDecoration(
//                         color: Colors.transparent,
//                       ),
//                       child: Center(child: CameraScreen(file: widget.cardinfo.file!)),
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: 50,
//                 height: 50,
//                 decoration: ShapeDecoration(
//                   color: AppColors.greylight,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: SizedBox(height: 90, width: 90, child: Image.asset("images/augmentedreality.png", color: AppColors.black)),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             CustomButton(width: 180, value: "Add to cart", color: AppColors.darkGrey),
//             const SizedBox(width: 10),
//             GestureDetector(
//               onTap: () {
//                 controller.isfavorate.value = !controller.isfavorate.value;
//                 controller.updateRecode(
//                   Item(
//                     price: widget.cardinfo.price,
//                     image: widget.cardinfo.image,
//                     rate: widget.cardinfo.rate,
//                     id: widget.cardinfo.id,
//                     type: widget.cardinfo.type,
//                     description: widget.cardinfo.description,
//                     isfavorite: controller.isfavorate.value,
//                     name: widget.cardinfo.name,
//                     file: widget.cardinfo.file,
//                     colors: widget.cardinfo.colors,
//                   ),
//                 );
//               },
//               child: Obx(() => Container(
//                 width: 50,
//                 height: 50,
//                 decoration: ShapeDecoration(
//                   color: AppColors.greylight,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: SizedBox(height: 90, width: 90, child: SvgPicture.asset("images/heart.svg", color: controller.isfavorate.value ? Colors.red : AppColors.darkGrey)),
//                 ),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/widgets/camerascreen.dart';
import 'package:myhb_app/widgets/custom_button.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatefulWidget {
  final Item cardinfo;

  const ProductDetails({required this.cardinfo, Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ItemController controller = Get.put(ItemController());
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: MediaQuery.of(context).size.height / 2.3,
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
                              minFieldOfView: '50deg',
                              cameraOrbit: '0deg 0deg 0.5m',
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
                            color: AppColors.black.withOpacity(.1),
                            blurRadius: 2,
                            offset: const Offset(-2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: widget.cardinfo.colors!.map((item) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                int selectedIndex =
                                    widget.cardinfo.colors!.indexOf(item);
                                controller.choosenItem.value = selectedIndex;
                                 print("the file name path ${widget.cardinfo.files?[controller.choosenItem.value ]}");
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: ShapeDecoration(
                                  color: Color(int.parse("0xFF$item")),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
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
                        widget.cardinfo.price ?? "",
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
                          child: CameraScreen(file: widget.cardinfo.files![controller.choosenItem.value]!)),
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
                          color: AppColors.black)),
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
  }
}
