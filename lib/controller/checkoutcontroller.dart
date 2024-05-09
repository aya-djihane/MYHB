import 'package:get/get.dart';
import 'package:myhb_app/service/database_service.dart';
import '../chekoutEntry.dart';

class CheckoutController extends GetxController {
  final DatabaseService _firestoreService = DatabaseService();

  final RxList<CheckoutEntry> checkoutList = <CheckoutEntry>[].obs;

  @override
  void onInit() {
    fetchCheckoutList();
    super.onInit();
  }

  Future<void> fetchCheckoutList() async {
    try {
      List<CheckoutEntry> fetchedList = await _firestoreService.getCheckoutList();
      checkoutList.assignAll(fetchedList);
      print("+++++++++${checkoutList.length}");
    } catch (e) {
      print("Error fetching checkout list: $e");
    }
  }
}


