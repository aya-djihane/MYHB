import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myhb_app/controller/account_controller.dart';
import 'package:myhb_app/models/user.dart';
import 'package:myhb_app/screens/dashbord.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../appColors.dart';
class AuthController extends GetxController {
  final AccountController accountcontroller = Get.put(AccountController());
  RxBool ckiked = false.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int failedLoginAttempts = 0;
  RxBool stop = false.obs;
  Timer? loginTimer;
  @override
  void onInit() {
    super.onInit();
    checkUserLogin();
  }
  Future<void> checkUserLogin() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await saveUserInfo(user);
      Get.offAll(const UserDashboard());
    }
  }
  Future<void> login(String email, String password) async {
    try {
      if (email.isEmpty || !isEmailValid.value) {
        isEmailValid.value = false;
        return;
      }
      if (password.isEmpty || !isPasswordValid.value) {
        isPasswordValid.value = false;
        return;
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await saveUserInfo(userCredential.user!);
      failedLoginAttempts = 0;
      Get.snackbar('Success', 'User exists!',
          backgroundColor: AppColors.primaryGreen.withOpacity(.2));
      Get.offAll(const UserDashboard()); // Go to dashboard after login
    } on FirebaseAuthException catch (e) {
      failedLoginAttempts++;
      if (failedLoginAttempts >= 3) {
        stop.value=true;
        showLoginAttemptsDialog();
        if (loginTimer != null && loginTimer!.isActive) {
          loginTimer!.cancel();
        }
        loginTimer = Timer(Duration(seconds: 20), () {
          failedLoginAttempts = 0;
          loginTimer = null;
        });
      }
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.',colorText: AppColors.white,backgroundColor: Colors.red,icon: const Icon(Icons.warning,color: Colors.white, ));
      }
      else if (e.code.contains('network-request-failed') ) {
        Get.snackbar('Error', 'Wrong password provided for that user.',colorText: AppColors.white,backgroundColor: Colors.red,icon: const Icon(Icons.warning,color: Colors.white, ));
      } else {
        print('Error: $e');
        Get.snackbar('Error', 'Failed to sign in: try again with right password',colorText: AppColors.white,backgroundColor: Colors.red,icon: const Icon(Icons.warning,color: Colors.white, ));
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to sign in: try again with right password ',colorText: AppColors.white,backgroundColor: Colors.red,icon: const Icon(Icons.warning,color: Colors.white, ));
    }
  }
  Future<void> saveUserInfo(User user) async {
    Users userInfo = Users(id: user.uid, name: user.displayName, email: user.email);
    Map<String, Object?> userInfoJson = userInfo.toJson();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userInfo', jsonEncode(userInfoJson));
    print("userInfo: ${userInfo.email}");
    accountcontroller.fetchUsersAndCheckEmail();
  }
  void showLoginAttemptsDialog() {
    int countDownSeconds = 30;
    Get.defaultDialog(
      backgroundColor: AppColors.white,
      title: 'Login Attempts Limit Exceeded',
      titlePadding: const EdgeInsets.only(top: 20),
      barrierDismissible: false,
      titleStyle: const TextStyle(fontSize: 17,fontWeight: FontWeight.w900,color: Colors.red),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_outlined,color: Colors.red),
              const Text(
                'You have exceeded the maximum number of login attempts.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: countDownSeconds / 30,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red), 
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),
               Text(
                '$countDownSeconds S',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14,color: Colors.red,fontWeight: FontWeight.w600),
              ),
            ],
          );
        },
      ),
    );

    Timer.periodic(const Duration(seconds: 1), (timer) {
      countDownSeconds--;
      if (countDownSeconds == 0) {
        timer.cancel();
        stop.value=false;
        Get.back();
      }
    });
  }
}