import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/widgets/custom_text.dart';
enum PageType {home, meet, account,announcements}
class BottomBar extends StatefulWidget {
  final Function() onTapHome;
  final Function() onTapMeet;
  final Function () onTapAnnouncements;
  final Function() onTapAccount;
  final PageType pageType;

  const BottomBar({
    Key? key,
    required this.onTapHome,
    required this.onTapMeet,
    required this.onTapAccount,
    required this.onTapAnnouncements,
    this.pageType = PageType.home,
  }) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}
class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: media.width,
      height: media.height*0.0849753694581281,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.grey, width: 1)),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: _customIconTap(
              icon: widget.pageType == PageType.home ? Iconsax.home_1:  Iconsax.home ,
              text: 'Home',
              color: widget.pageType == PageType.home ? AppColors.lightblack:AppColors.grey,
              onTap: widget.onTapHome,
            ),
          ),
          Expanded(
            flex: 1,
            child: _customIconTap(
              icon: widget.pageType == PageType.announcements ? Iconsax.save_2:  Iconsax.save_add_copy ,
              text: 'Home',
              color: widget.pageType == PageType.announcements? AppColors.blacklight:AppColors.grey,
              onTap: widget.onTapAnnouncements,
            ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap:  widget.onTapMeet,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.pageType == PageType.meet ? Iconsax.notification:Iconsax.notification_copy,
                      size: 28.sp,
                      color: widget.pageType == PageType.meet ? AppColors.lightblack:AppColors.grey,

                    ),

                  ],
                ),
              )
          ),
          Expanded(
            flex: 1,
            child: _customIconTap(
              icon: widget.pageType == PageType.account ? IconlyBold.profile : IconlyLight.profile,
              text: 'Account',
              color: widget.pageType == PageType.account ? AppColors.lightblack:AppColors.grey,
              onTap: widget.onTapAccount,
            ),
          ),
        ],
      ),
    );
  }
  Widget _customIconTap({required IconData icon, required String text, required Color color, required Function() onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28.sp,
            color: color,
          ),
          SizedBox(height: 3.h),

        ],
      ),
    );
  }
}

