import 'package:flutter/material.dart';
import '../appColors.dart';

class PrivacyTermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Terms'),
      ),
      floatingActionButton: const Text("Version 1.0.0",),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.yellow,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our mobile application. Please read this Privacy Policy carefully. IF YOU DO NOT AGREE WITH THE TERMS OF THIS PRIVACY POLICY, PLEASE DO NOT ACCESS THE APPLICATION.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkGrey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.yellow,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'By accessing and using this mobile application, you agree to be bound by the following Terms of Service. If you do not agree to abide by these terms, you are not authorized to use the application.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
