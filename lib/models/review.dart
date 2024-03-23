import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
class Review {
  String? id;
  final String? name;
  final String? images;
  final int? rating;
  final String? review;
  Review( {
    this.name,
    this.rating,
    this.images,
    this.id,
    this.review,
  });
  factory Review.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Review(
      id: data['id'] ,
      name: data['name'] as String?,
      rating: data['rating']??0,
      review: data['review'] as String?,
      review: data['images'] as String?,
    );
  }
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'review': review,
      'rating': rating

    };
  }
}

