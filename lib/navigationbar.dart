import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  var index = 0.obs;

  void changeTab(int newIndex) {
    index.value = newIndex;
  }
}

class NavigationBarView extends StatelessWidget {
  final controller = Get.put(NavigationBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        destinations: <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), label: 'Favorite'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined), label: 'Notification'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    ));
  }
}
