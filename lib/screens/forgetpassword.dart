import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/auth/forgetPassword_controller.dart';
import 'package:myhb_app/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: GetX<ForgotPasswordController>(
        init: forgotPasswordController,
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
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
                      'Forgot Password',
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
                  onChanged: (value) => controller.validateEmail(value),
                  decoration:  InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: AppColors.blacklight),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:controller.isEmailValid.value? AppColors.grey:AppColors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryGreen),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.black),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                  child: CustomButton(width: media.width, value: 'Reset Password', onTap: () => controller.resetPassword()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}