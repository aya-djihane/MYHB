import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/account_controller.dart';
import 'package:myhb_app/controller/app_controller.dart';
import 'package:myhb_app/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AccountController controller = Get.put(AccountController());
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
   String USER_COLLECTON_REF="users";
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await uploadImageToFirebase(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }
  Widget buildProfileImage() {
    final profileUrl = controller.currentUser.value?.profil;
    if (profileUrl != null) {
      return Image.network(
        profileUrl,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.yellow,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }
        },
      );
    } else {
      return const CircularProgressIndicator(color: AppColors.yellow,);
    }
  }

  Future<void> uploadImageToFirebase(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref =
      storage.ref().child('test/$fileName.jpg');
      await ref.putFile(file);
      String imageUrl = await ref.getDownloadURL();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userInfoJson = prefs.getString('userInfo') ?? "";
      Map<String, dynamic> userInfo = jsonDecode(userInfoJson);
      String userEmail = userInfo['id'];
      FirebaseFirestore.instance
          .collection(USER_COLLECTON_REF)
          .doc("${controller.currentUser.value!.id}")
          .update({'profile': imageUrl});
      print('Image uploaded to Firebase Storage. Image URL: $imageUrl');
      controller. fetchUsersAndCheckEmail();
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
@override
  void initState() {
    controller.fetchUsersAndCheckEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
       Obx(() => SizedBox(
         height: 100.h,
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(width: 20.w),
             Stack(
               children: [
                 SizedBox(
                   height: 75.h,
                   width: 80.w,
                   child: ClipOval(
                     child: controller.loading.value
                         ? const Center(
                       child: CircularProgressIndicator(
                         color: AppColors.yellow,
                       ),
                     )
                         : SizedBox(
                       width: 80,
                       height: 70,
                       child: controller.currentUser.value!.profil!.isNotEmpty
                           ? buildProfileImage()
                           : Image.asset("images/images-removebg-preview.png"),
                     ),
                   ),
                 ),
                 Positioned(
                   bottom: -10,
                   right: -12,
                   child: IconButton(
                     icon: Icon(
                       Icons.add_a_photo,
                       color: Theme.of(context).brightness == Brightness.light
                           ? AppColors.blackDark
                           : AppColors.yellow,
                     ),
                     onPressed: _pickImage,
                   ),
                 ),
               ],
             ),
             const SizedBox(width: 10,),
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 CustomText(
                   value: '${controller.currentUser.value!.name??""} ',
                   type: TypeText.text6,
                   color: Theme.of(context).brightness == Brightness.light
                       ? AppColors.black
                       : AppColors.yellow,
                 ),
                 const SizedBox(height: 8,),
                 CustomText(
                   value: '${controller.currentUser.value!.email??""} ',
                   type: TypeText.text3,
                   color: Theme.of(context).brightness == Brightness.light
                       ? AppColors.darkGrey
                       : AppColors.yellow,
                 )
               ],
             )
           ],
         ),
       ),),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.white
                      : AppColors.lightBlackDark,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(),
                  ]),
              height: 69.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Theme.of(context).brightness == Brightness.light
                            ? Icons.light_mode
                            : Icons.dark_mode),
                        SizedBox(width: 20.w,),
                        CustomText(
                          value: Theme.of(context).brightness == Brightness.light
                              ? 'light mood'
                              : 'dark mood',
                          type: TypeText.text3,
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.darkGrey
                              : AppColors.yellow,
                        ),
                      ],
                    ),
                    Switch(
                      activeColor: AppColors.yellow,
                      value: Theme.of(context).brightness == Brightness.light,
                      onChanged: (value) {
                        if (Theme.of(context).brightness == Brightness.light) {
                          final uiProvider = Provider.of<UiProvider>(context, listen: false);
                          uiProvider.changeThem();
                        } else {
                          final uiProvider = Provider.of<UiProvider>(context, listen: false);
                          uiProvider.changeThem();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0,left: 20,right: 20),
            child: Container (
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.white
                      : AppColors.lightBlackDark,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(),
                  ]),
              height: 69.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          value:'My Orders '
                          ,
                          type: TypeText.text,
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.darkGrey
                              : AppColors.yellow,
                        ),
                        const SizedBox(height: 10,),
                        CustomText(
                          value:'Already have 10 orders',
                          type: TypeText.subsubtext2,
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.grey
                              : AppColors.yellow,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(


                      Icons.arrow_forward_ios,

                      size: 17,
                      color:Theme.of(context).brightness == Brightness.light
                        ? AppColors.darkGrey
                        : AppColors.yellow,),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0,left: 20,right: 20),
            child: Container (
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.white
                      : AppColors.lightBlackDark,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(),
                  ]),
              height: 69.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          value:'My reviews '
                          ,
                          type: TypeText.text,
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.darkGrey
                              : AppColors.yellow,
                        ),
                        const SizedBox(height: 10,),
                        CustomText(
                          value:'Reviews for 5 items',
                          type: TypeText.subsubtext2,
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.grey
                              : AppColors.yellow,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(


                      Icons.arrow_forward_ios,

                      size: 17,
                      color:Theme.of(context).brightness == Brightness.light
                        ? AppColors.darkGrey
                        : AppColors.yellow,),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0,left: 20,right: 20),
            child: Container (
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.white
                      : AppColors.lightBlackDark,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(),
                  ]),
              height: 69.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          value:'Setting'
                          ,
                          type: TypeText.text,
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.darkGrey
                              : AppColors.yellow,
                        ),
                        const SizedBox(height: 10,),
                        CustomText(
                          value:'Update , FAQ , Contact ',
                          type: TypeText.subsubtext2,
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.grey
                              : AppColors.yellow,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(


                      Icons.arrow_forward_ios,

                      size: 17,
                      color:Theme.of(context).brightness == Brightness.light
                        ? AppColors.darkGrey
                        : AppColors.yellow,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: SizedBox(
        child: Text(
          "Profile",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "Gelasio",
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.black
                : AppColors.yellow,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            controller.logout();
          },
          child: const Icon(Icons.logout, color: Colors.red),
        ),
        const SizedBox(width: 10,),
      ],
    );
  }
}
