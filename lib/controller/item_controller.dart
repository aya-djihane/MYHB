import 'package:get/get.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/models/review.dart';
import 'package:myhb_app/models/user.dart';
import 'package:myhb_app/service/database_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ItemController extends GetxController {
  RxBool isfavorate = false.obs;
  RxInt choosenItem = 0.obs;
  RxInt reviewInt = 0.obs;
  RxString message = "".obs;
  Rx<Review> choosenreview = Review().obs;

  late DatabaseService _databaseService;
  Future<void> updateRecode(Item item) async {
    await DatabaseService().updateItemRecord(item);
  }
  Future<void> createfavorate(Item item) async {
    await DatabaseService().CreatItemFavorateRecord(item);
  }
  Future<bool> addreview(Item item) async {
    // Fetch user information from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userName = prefs.getString('userName');
    String? userEmail = prefs.getString('userEmail');
    Users user = Users(id: userId, name: userName, email: userEmail);
    choosenreview.value = Review(
      id: item.id,
      review: message.value,
      item: item,
      user: user,
      rating: reviewInt.value,
    );
    await createitemReview();
    return true;
  }
  Future<void> createitemReview() async {
    await DatabaseService().CreatItemReviwRecord(choosenreview.value);
  }
}
