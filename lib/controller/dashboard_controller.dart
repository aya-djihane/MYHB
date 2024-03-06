import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/service/database_service.dart';
import 'package:myhb_app/widgets/buttom_bar.dart';

class DashboardController extends GetxController {
  Rx<PageType> pageType = PageType.home.obs;
  final DatabaseService databaseService =DatabaseService();
  List<String> images = [
    "https://th.bing.com/th/id/R.3e063dbea335dd01a2b9f08e8483e221?rik=GgQUab%2bcvdoeVA&pid=ImgRaw&r=0",
    "https://i.pinimg.com/736x/bf/0f/6d/bf0f6d931224d9e128e65e22e7f1d1fa.jpg",
    "https://clipground.com/images/chair-pic-png-11.png",
    "https://th.bing.com/th/id/R.70a6e9b8acaa19cb687f50311bbedc72?rik=VcXWWxcLCMODMw&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f7%2fChair-PNG-Free-Download.png&ehk=9irAF%2b8H1PPqWh5faBlvgTStSOByLF3Qv6kSsBdh7pk%3d&risl=&pid=ImgRaw&r=0",
    "https://th.bing.com/th/id/OIP.zt3_9dU0AvYoVEtbVcUzJgHaHa?rs=1&pid=ImgDetMain",
  ];

  // Future<List<Item>> generateRandomItems(int count) {
  //   List<Item> randomItems = [];
  //   for (int i = 0; i < count; i++) {
  //     String randomImage = images[Random().nextInt(5)];
  //     String randomPrice = "${Random().nextInt(1000) + 500}DA";
  //     String randomName = "${Random().nextInt(50)} Item ";
  //     Type randoomtype = Type.values[Random().nextInt(4)];
  //
  //     String description = "Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ";
  //     int rate = Random().nextInt(10);
  //     randomItems.add(Item(
  //         id: i,
  //         image: randomImage,
  //         price: randomPrice,
  //         name: randomName,
  //         type: randoomtype,
  //       description: description,
  //       rate: rate
  //
  //     ));
  //
  //   }
  //
  //   return Future.value(randomItems);
  // }

  Future<List<Item>> fetchItemsFromFirebase() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('items').get();

      List<Item> items = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        items.add(Item(
          id: doc['id'],
          price: doc['price'],
          name: doc['name'],
        ));
      }

      return items;
    } catch (e) {
      print('Error fetching items from Firestore: $e');
      return [];
    }
  }
}
