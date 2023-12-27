import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/auth/signup_controller.dart';
import 'package:myhb_app/screens/loginscreen.dart';
import 'package:myhb_app/widgets/custom_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SigninController signinController = Get.put(SigninController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetX<SigninController>(
        init: signinController,
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                  child: Row(
                    children: [
                      Container(width: media.width / 3.3, height: 1, color: AppColors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(height: 90, width: 90, child: SvgPicture.asset("svgfiles/login.svg", color: AppColors.black)),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(width: media.width / 3.3, height: 1, color: AppColors.grey),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0, top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greydark,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: TextFormField(
                  obscureText: false,
                  onChanged: (value) { controller.validateName(value);
                    controller.name.value=value;

                  },
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(color: AppColors.blacklight),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryGreen),
                    ),
                  ),
                  style: TextStyle(color: AppColors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: TextFormField(
                  controller: emailController,
                  onChanged: (value) => controller.validateEmail(value),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: AppColors.blacklight),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryGreen),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: controller.ckiked.value,
                  onChanged: (value) => controller.validatePassword(value),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffix: InkWell(
                      onTap: () {
                        controller.ckiked.value = !controller.ckiked.value;
                      },
                      child: controller.ckiked.value?
                      const Icon(Ionicons.eye_off, color: AppColors.darkGrey):const Icon(Ionicons.eye, color: AppColors.darkGrey),
                    ),
                    hintStyle: const TextStyle(color: AppColors.blacklight),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryGreen),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20.0),
                child: TextFormField(
                  obscureText:   controller.ckikedConfirm.value,
                  onChanged: (value) => controller.validateConfirmPassword(value),

                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    suffix: InkWell(
                      onTap: () {
                        controller.ckikedConfirm.value = !controller.ckikedConfirm.value;
                      },
                      child: controller.ckikedConfirm.value?
                      const Icon(Ionicons.eye_off, color: AppColors.darkGrey):const Icon(Ionicons.eye, color: AppColors.darkGrey),
                    ),
                    hintStyle: const TextStyle(color: AppColors.blacklight),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryGreen),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.blacklight),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: CustomButton(width: media.width, value: 'Sign Up', onTap: () => controller.signup(emailController.text,passwordController.text)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const LoginScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: media.width / 4.5, top: 0),
                  child: const Text(
                    'Already have an account? Sign In',
                    style: TextStyle(fontSize: 14, fontFamily: "Merriweather", fontWeight: FontWeight.w600, color: AppColors.blacklight),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
