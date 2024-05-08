import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {

  final String title;
  final String subtitle;
  final String image;
  final int isreded;

  Notification({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.isreded,

  });

  factory Notification.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Notification(
        title: (data['title'] ??"")  ,
        subtitle:(data['subtitle'] ??"")  ,
        image: (data['image'] ??"")  ,
        isreded: (data["isreded"]??0)
    );
  }

  Map<String, Object?> toJson() {
    return {

      'title':title,
      'subtitle':subtitle,
      'image':image,
      'isreded':isreded
    };
  }
}
