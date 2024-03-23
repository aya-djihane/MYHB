import 'package:get/get.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/service/database_service.dart';

class ItemController extends GetxController {
  RxBool isfavorate= false.obs;
  RxInt choosenItem= 0.obs;
  RxInt reviewInt= 0.obs;
  RxString message= "".obs;
  late DatabaseService _databaseService;

  Future<void> updateRecode(Item item) async {
    await DatabaseService().updateItemRecord(item);
  }

  Future<void> createfavorate(Item item) async {
    await DatabaseService().CreatItemFavorateRecord(item);
  }

}
