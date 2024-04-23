import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/models/user.dart';

class Review {
  Users? user;
  String? id;
  Item? item;
  final int? rating;
  final String? review;
  Review({
    this.id,
    this.item,
    this.user,
    this.rating,
    this.review,
  });
  factory Review.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Review(
      id: data['id'],
      item: Item.fromMap(data['item']),
      user: Users.fromMap(data['user']),
      rating: data['rating'] as int?,
      review: data['review'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'user':user?.toJson(),
      'item': item?.toJson(),
      'rating': rating,
      'review': review,
    };
  }
}
