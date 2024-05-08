import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myhb_app/models/cart_item.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/models/notification.dart';
import 'package:myhb_app/models/review.dart';
import 'package:myhb_app/models/user.dart';
import 'package:myhb_app/service/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account_controller.dart';
class ItemController extends GetxController {
  RxBool isfavorate = false.obs;
  RxInt choosenItem = 0.obs;
  RxInt reviewInt = 0.obs;
  Rx choosenID = "".obs;
  RxString message = "".obs;
  Rx<Review> choosenreview = Review().obs;
  RxList<Review> globalReview = <Review>[].obs;
  RxList<CartItem> globalorderitem = <CartItem>[].obs;
  RxList<Review> selectedreviews = <Review>[].obs;
  RxList<CartItem> selectedItemscart = <CartItem>[].obs;
  RxDouble totalorder=0.0.obs;
  RxBool loadingOrder = false.obs;
  RxList<Notification> notification = <Notification>[].obs;
  final AccountController accountController = Get.find();
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
  Future<void> updateCounter(Item item,int counter) async {
    await DatabaseService().updateItemCounter(item.id!,counter);
  }
  Future<void> createfavorate(Item item) async {
    await DatabaseService().CreatItemFavorateRecord(item);
  }
  Future<void> getnotification() async {
    _databaseService.getNotification().listen((items) {
      notification.assignAll(items);
    });
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
        profil: user.email,
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
      globalReview.assignAll(items);
      print("the global list lenght is ${globalReview.length}");
    });
  }
  Future<void> fetchOrderItems() async {
    loadingOrder.value = true;
    try {
      final StreamSubscription<List<CartItem>> subscription =
      _databaseService.getOrderItems().listen((items) {
        globalorderitem.assignAll(items);
        selectedItemscart.clear();
        selectedItemscart.addAll(globalorderitem
            .where((p0) => p0.userEmail == accountController.currentUser.value!.email));
        totalorder.value = 0.0;
        selectedItemscart.forEach((element) {
          totalorder.value += double.parse(element.item.price!.replaceAll("dz", ""));
        });
        loadingOrder.value = false;
      });

    } catch (e) {
      print('Error fetching order items: $e');
      loadingOrder.value = false;
    }
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
