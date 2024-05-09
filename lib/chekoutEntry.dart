import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhb_app/models/cart_item.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/widgets/ItemCard.dart';

class CheckoutEntry {
  final String id;
  final CartItem item;
  final String userEmail;
  final String checkoutDate;

  CheckoutEntry({
    required this.id,
    required this.item,
    required this.userEmail,
    required this.checkoutDate,
  });
  factory CheckoutEntry.fromJson(Map<String, dynamic> json) {
    return CheckoutEntry(
      id: json['id'],
      item: CartItem.fromMap(json['item']),
      userEmail: json['useremail'],
      checkoutDate: json['checkoutdate'],
    );
  }
  factory CheckoutEntry.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return CheckoutEntry.fromJson(json);
  }
}