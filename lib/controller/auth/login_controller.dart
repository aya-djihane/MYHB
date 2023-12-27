import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../appColors.dart';

class AuthController extends GetxController {
  RxBool ckiked = false.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;

  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {}

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

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Success', 'User exists!',backgroundColor: AppColors.primaryGreen.withOpacity(.2));

    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in: $e');
    }
  }

}
