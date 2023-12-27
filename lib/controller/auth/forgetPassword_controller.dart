import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myhb_app/appColors.dart';

class ForgotPasswordController extends GetxController {
  RxBool isEmailValid = true.obs;
  RxString email = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void validateEmail(String value) {
    isEmailValid.value = GetUtils.isEmail(value);
    email.value = value;
  }

  Future<void> resetPassword() async {
    try {
      if (isEmailValid.value) {
        await _auth.sendPasswordResetEmail(email: email.value);
        Get.snackbar('Success', 'Password reset email sent to ${email.value}',backgroundColor: AppColors.primaryGreen.withOpacity(.5));
      } else {
        Get.snackbar('Error', 'Please enter a valid email address',backgroundColor: AppColors.golden.withOpacity(.5));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send password reset email: $e');
    }
  }
}
