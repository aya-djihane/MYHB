import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhb_app/models/item.dart';
class CartItem {
  final Item item;
  final DateTime date;
  final String item_id;
  final String userEmail;
  final int counter;
  CartItem({
    required this.item,
    required this.date,
    required this.item_id,
    required this.userEmail,
    required this.counter,
  });
  factory CartItem.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CartItem(
      item: Item.fromMap(data['item'] as Map<String, dynamic>),
      date: (data['date'] as Timestamp).toDate(),
      item_id: (data['item_id'] ??"")  ,
      userEmail: (data['userEmail']??"" ),
      counter: (data["counter"]??1)
    );
  }
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      item: Item.fromMap(map['item'] as Map<String, dynamic>),
      date: (map['date'] as Timestamp).toDate(),
      item_id: map['item_id'] as String? ?? "",
      userEmail: map['userEmail'] as String? ?? "",
      counter: map['counter'] as int? ?? 1,
    );
  }


  Map<String, Object?> toJson() {
    return {
      'item': item.toJson(),
      'date': date,
      'item_id':item_id,
      'userEmail':userEmail,
      'counter':counter
    };
  }
}
