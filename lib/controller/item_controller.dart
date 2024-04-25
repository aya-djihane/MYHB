import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/models/review.dart';
import 'package:myhb_app/models/user.dart';
import 'package:myhb_app/service/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ItemController extends GetxController {
  RxBool isfavorate = false.obs;
  RxInt choosenItem = 0.obs;
  RxInt reviewInt = 0.obs;
  Rx choosenID = "".obs;
  RxString message = "".obs;
  Rx<Review> choosenreview = Review().obs;
  RxList<Review> globalReview = <Review>[].obs;
  RxList<Review> selectedreviews = <Review>[].obs;
  final StreamController<List<Review>> _filteredItemsController =
  StreamController<List<Review>>.broadcast();
  Stream<List<Review>> get filteredItemsStream =>
      _filteredItemsController.stream;
@override
  void onInit() async{
  _databaseService = DatabaseService();
 await fetchItems();
  super.onInit();
  }
  late DatabaseService _databaseService;
  Future<void> updateRecode(Item item) async {
    await DatabaseService().updateItemRecord(item);
  }
  Future<void> createfavorate(Item item) async {
    await DatabaseService().CreatItemFavorateRecord(item);
  }
  Future<bool> addreview(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userInfo');
    DateTime dateObj = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateObj);
    if(userData != null) {
      Map<String, dynamic> userInfoJson = jsonDecode(userData);
      Users user = Users.fromMap(userInfoJson);
      choosenreview.value = Review(
        id: item.id,
        review: message.value,
        item: item,
        rating: reviewInt.value,
        profil: user.profil,
        date: formattedDate,
      );
      await fetchItems();
      chooseitem(choosenID.value);
      await createitemReview();
      return true;
    } else {
      return false;
    }
  }
  Future<void>  fetchItems() async{
    _databaseService.getReviews().listen((items) {
      globalReview.value.assignAll(items);
      print("the global list lenght is ${globalReview.length}");
    });
  }
  void chooseitem(String id ) {
    selectedreviews.clear();
    selectedreviews.addAll(globalReview.where((p0) => p0.item!.id==id));
    print("the selected items freviews lenght == ${selectedreviews.length}");
  }
  Future<void> createitemReview() async {
    await DatabaseService().CreatItemReviwRecord(choosenreview.value);
    fetchItems();
  }
}
