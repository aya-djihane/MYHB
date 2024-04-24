import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/models/user.dart';

class Review {
  String? id;
  Item? item;
  final int? rating;
  final String? review;
  final String? profil;
  final String ? date;
  Review({
    this.id,
    this.item,
    this.rating,
    this.review,
    this .profil,
    this.date,
  });
  factory Review.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Review(
      id: data['id'],
      item: Item.fromMap(data['item']),
      rating: data['rating'] as int?,
      review: data['review'] as String?,
      profil:data['profil'] as String?,
      date:data['date'] as String?,

    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'item': item?.toJson(),
      'rating': rating,
      'review': review,
      "profil":profil,
      "date":date
    };
  }
}
