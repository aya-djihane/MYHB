import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myhb_app/models/review.dart';
import 'package:myhb_app/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:myhb_app/models/user.dart';
import '../service/database_service.dart';
class AccountController extends GetxController {
  RxList<Users> users = <Users>[].obs;
  Rx<Users?> currentUser = Users().obs;
  RxBool loading =false.obs;
  RxList<Review> globalReview = <Review>[].obs;
  RxList<Review> selectedreviews = <Review>[].obs;
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    await prefs.remove('userToken');
    await prefs.remove('userInfo');
    DefaultCacheManager().emptyCache();
    await _auth.signOut();

    Get.offAll(const SplashScreen()); // Use Get for navigation
  }
}
