import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/service/database_service.dart';

class ItemController extends GetxController {

  Future<void> updateRecode(Item item) async {
    await DatabaseService().updateItemRecord(item);
  }

}
