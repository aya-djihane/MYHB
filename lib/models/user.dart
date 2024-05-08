import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
class Users {
  String? id;
  final String? name;
  final String? profil;
   final String? email;
  Users( {
    this.name,
    this.profil,
    this.id,
    this.email,

  });

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>?
    if (data == null) {
      throw Exception('DocumentSnapshot data was null');
    }
    return Users(
      id: data['id'] as String,
      name: data['name'] as String?,
      email:data['email'] as String?,
      profil: data['profile'] as String?,
    );
  }

  factory Users.fromMap(Map<String, dynamic> data) {
    return Users(
      id: data['id'] ,
      name: data['name'] as String?,
      email:data['email'] as String?,
      profil: data['profile'] ??""as String,

    );
  }
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile': profil

    };
  }
}

