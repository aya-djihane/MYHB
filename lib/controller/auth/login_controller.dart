import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myhb_app/models/user.dart';
import 'package:myhb_app/screens/dashbord.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../appColors.dart';

class AuthController extends GetxController {
  RxBool ckiked = false.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      Get.snackbar('Success', 'User exists!',
          backgroundColor: AppColors.primaryGreen.withOpacity(.2));
      Get.offAll(const UserDashboard()); // Go to dashboard after login
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else {
        print('Error: $e');
        Get.snackbar('Error', 'Failed to sign in: $e');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to sign in: $e');
    }
  }

  Future<void> saveUserInfo(User user) async {
    Users userInfo =
    Users(id: user.uid, name: user.displayName, email: user.email);
    Map<String, Object?> userInfoJson = userInfo.toJson();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userInfo', jsonEncode(userInfoJson));
    print("userInfo: ${userInfo.email}");
  }
}
