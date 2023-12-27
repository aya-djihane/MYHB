import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/screens/forgetpassword.dart';
import 'package:myhb_app/widgets/custom_button.dart';
import 'package:myhb_app/screens/SignUpScreen.dart';
import '../controller/auth/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GetX<AuthController>(
      init: authController,
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                    child: Row(
                      children: [
                        Container(width: media.width / 3.2, height: 1, color: AppColors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(height: 90, width: 90, child: SvgPicture.asset("svgfiles/login.svg", color: AppColors.black)),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(width: media.width / 3.2, height: 1, color: AppColors.grey),
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
                        'Hello!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "RubikLines",
                          fontWeight: FontWeight.bold,
                          color: AppColors.greydark,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      // Add more email validation if needed
                      return null;
                    },
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
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: controller.ckiked.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: () {
                          controller.ckiked.value = !controller.ckiked.value;
                        },
                        child: controller.ckiked.value?
        const Icon(Ionicons.eye_off, color: AppColors.darkGrey):const Icon(Ionicons.eye, color: AppColors.darkGrey),
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: AppColors.blacklight),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryGreen),
                      ),
                    ),
                    style: TextStyle(color: AppColors.black),
                  ),
                ),
                InkWell(
                  onTap: ()=>Get.to(const ForgotPasswordScreen()),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 50, top: 0),
                    child: Text('forgot password ?', style: TextStyle(fontSize: 16, fontFamily: "Nunito", fontWeight: FontWeight.w600, color: AppColors.grey)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                    child: Column(
                      children: [
                        CustomButton(width: media.width, value: 'Log In', onTap: () => controller.login(emailController.text, passwordController.text)),
                        SizedBox(height: 16),
                        CustomButton(width: media.width, value: 'SIGN UP', onTap: () => Get.to(SigninScreen())),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
