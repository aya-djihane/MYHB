import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/account_controller.dart';

class SendMessageScreen extends StatefulWidget {
  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  AccountController controller= Get.find();

  @override
  void initState() {
    _emailController.text=controller.currentUser.value!.email!;
    _nameController.text=controller.currentUser.value!.name!;
    super.initState();
  }
  void _sendMessage() {
    String name = _nameController.text;
    String email = _emailController.text;
    String message = _messageController.text;
    FirebaseFirestore.instance.collection('messages').add({
      'name': name,
      'email': email,
      'message': message,
      'timestamp': DateTime.now(),
    });
Get.snackbar (" message sened to admin","");
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330.h,
      decoration:  BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.white:AppColors.lightBlack,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              Container(height: 3,width: 90,decoration: const BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20), topLeft: Radius.circular(20))
              ),),
              const SizedBox(height: 10,),
              Text(
                " Contect US",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.yellow // Use light mode color
                      : AppColors.yellow, // Use dark mode color
                  fontFamily: "Roboto",
                ),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                  ) ,
              ),
              TextField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: null,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                decoration:  BoxDecoration(
                  color: AppColors.golden,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("send to Us ",style: TextStyle(color: AppColors.white),),
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
