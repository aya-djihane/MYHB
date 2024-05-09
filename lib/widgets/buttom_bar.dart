import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
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
  final DashboardController dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: media.width,
      height: media.height*0.0849753694581281,
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        border:  Border(top: BorderSide(color:Theme.of(context).brightness == Brightness.light
            ? AppColors.yellow.withOpacity(.5):AppColors.yellow , width: 1)),
        color:  Theme.of(context).brightness == Brightness.light
          ? AppColors.white
          : AppColors.lightBlack,
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
              color: widget.pageType == PageType.home ? Theme.of(context).brightness == Brightness.light
                  ? AppColors.yellow:AppColors.yellow :Theme.of(context).brightness == Brightness.light
                  ?AppColors.yellow.withOpacity(.5):AppColors.yellow,
              onTap: widget.onTapHome,
            ),
          ),
          Expanded(
            flex: 1,
            child: _customIconTap(
              icon: widget.pageType == PageType.announcements ? Iconsax.save_2:  Iconsax.save_add_copy ,
              text: 'Home',
              color: widget.pageType == PageType.announcements?  Theme.of(context).brightness == Brightness.light
                ? AppColors.yellow:AppColors.yellow :Theme.of(context).brightness == Brightness.light
              ?AppColors.yellow.withOpacity(.5):AppColors.yellow,
              onTap: widget.onTapAnnouncements,
            ),
          ),
          Obx(() => Expanded(
              flex: 1,
              child: GestureDetector(
                onTap:  widget.onTapMeet,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    badges.Badge(
                      badgeStyle:  badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        badgeColor: !dashboardController.notifier.value?Colors.transparent:Colors.red,
                        padding: EdgeInsets.all(5),
                        borderSide: BorderSide(color:!dashboardController.notifier.value?Colors.transparent: Colors.white, width: 2),
                      ),
                      position: badges.BadgePosition.topEnd(top: -1, end: -1),
                      ignorePointer: true,
                      child: Icon(
                        widget.pageType == PageType.meet ? Iconsax.notification:Iconsax.notification_copy,
                        size: 28.sp,
                        color: widget.pageType == PageType.meet ? Theme.of(context).brightness == Brightness.light
                            ? AppColors.yellow:AppColors.yellow :Theme.of(context).brightness == Brightness.light
                            ?AppColors.yellow.withOpacity(.5):AppColors.yellow,

                      ),
                    ),
                  ],
                ),
              )
          ),),
          Expanded(
            flex: 1,
            child: _customIconTap(
              icon: widget.pageType == PageType.account ? IconlyBold.profile : IconlyLight.profile,
              text: 'Account',
              color: widget.pageType == PageType.account ? Theme.of(context).brightness == Brightness.light
                  ? AppColors.yellow:AppColors.yellow :Theme.of(context).brightness == Brightness.light
                  ?AppColors.yellow.withOpacity(.5):AppColors.yellow,
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

