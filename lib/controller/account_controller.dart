import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myhb_app/models/review.dart';
import 'package:myhb_app/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:myhb_app/models/user.dart';

import '../service/database_service.dart';

class AccountController extends GetxController {
  RxList<Users> users = <Users>[].obs;
  Rx<Users?> currentUser = Users().obs;
  RxBool loading =false.obs;
  RxList<Review> globalReview = <Review>[].obs;
  RxList<Review> selectedreviews = <Review>[].obs;
  final DatabaseService _databaseService = DatabaseService();
  @override
  void onInit() {
    super.onInit();
    fetchItems();
    fetchUsersAndCheckEmail();
    choosenmyreviewlist();
  }
  Future<void>  fetchItems() async{
    _databaseService.getReviews().listen((items) {
      globalReview.value.assignAll(items);
      print("the global list lenght is ${globalReview.length}");
      choosenmyreviewlist();
      print("the selected items freviews lenght == ${selectedreviews.length}");
    });
  }
  void fetchUsersAndCheckEmail()async {
    loading.value=true;
    currentUser.value=  await _databaseService.fetchUsersAndCheckEmail();
    loading.value=false;
     print(currentUser.value!.email);
  }
  void choosenmyreviewlist() {
    selectedreviews.clear();
    selectedreviews.addAll(globalReview.where((p0) => p0.profil==currentUser.value!.email));
    print("the selected items freviews lenght == ${selectedreviews.length}");
  }
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.to(const SplashScreen());
  }
}
