import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/screens/loginscreen.dart';

class SigninController extends GetxController {
  RxBool isNameValid = true.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  RxBool ckiked = false.obs;
  RxBool ckikedConfirm = false.obs;
  RxBool isConfirmPasswordValid = true.obs;
  RxString name = "".obs;
  RxBool loading = false.obs;
  void validateName(String value) {
    isNameValid.value = value.isNotEmpty;
  }

  void validateEmail(String value) {
    isEmailValid.value = value.isNotEmpty;
  }

  void validatePassword(String value) {
    isPasswordValid.value = value.isNotEmpty;
  }

  void validateConfirmPassword(String value) {
    isConfirmPasswordValid.value = value.isNotEmpty;
  }

  bool get isValidForm =>
      isNameValid.value && isEmailValid.value && isPasswordValid.value && isConfirmPasswordValid.value;
  Future<void> signup(String email, String password) async {
    loading.value==true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Successfully signed up: ${userCredential.user!.email}',backgroundColor: AppColors.primaryGreen.withOpacity(.2));
      loading.value==false;
Get.to(const LoginScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error: ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
