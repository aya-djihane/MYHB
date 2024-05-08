import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/account_controller.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/screens/Notification.dart';
import 'package:myhb_app/screens/account_screen.dart';
import 'package:myhb_app/screens/favoritescreen.dart';
import 'package:myhb_app/screens/home_page.dart';
import 'package:myhb_app/widgets/buttom_bar.dart';
class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);
  @override
  State<UserDashboard> createState() => _UserDashboardState();
}
class _UserDashboardState extends State<UserDashboard> {
  final DashboardController dashboardController = Get.put(DashboardController());
  final AccountController accountController = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent
        )
    );
    return GetX<DashboardController>(
        init: dashboardController,

        builder: (controller) {
          accountController.fetchUsersAndCheckEmail();

          return Scaffold(
            body: Stack(
              children: [
                if(dashboardController.pageType.value == PageType.home)
                  const HomePage(),
                if(dashboardController.pageType.value == PageType.announcements)
                   FavoritePage(),
                if(dashboardController.pageType.value == PageType.meet)
                   NotificationScreen(),
                if(dashboardController.pageType.value == PageType.account)
                  const AccountPage(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomBar(
                    onTapHome: () => dashboardController.pageType.value = PageType.home,
                    onTapAnnouncements:()=>  dashboardController.pageType.value = PageType.announcements,
                    onTapMeet:() =>dashboardController.pageType.value = PageType.meet,
                    onTapAccount: () => dashboardController.pageType.value = PageType.account,
                    pageType: dashboardController.pageType.value,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

