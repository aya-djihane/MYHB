import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myhb_app/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:myhb_app/models/user.dart';

import '../service/database_service.dart';

class AccountController extends GetxController {
  RxList<Users> users = <Users>[].obs;
  Rx<Users?> currentUser = Users().obs;
  RxBool loading =false.obs;
  final DatabaseService _databaseService = DatabaseService();
  @override
  void onInit() {
    super.onInit();
   fetchUsersAndCheckEmail();
  }

  void fetchUsersAndCheckEmail()async {
    loading.value=true;
    currentUser.value=  await _databaseService.fetchUsersAndCheckEmail();
    loading.value=false;
     print(currentUser.value!.id);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.to(const SplashScreen());
  }
}
