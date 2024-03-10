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
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Users(
      id: data['id'] ,
      name: data['name'] as String?,
      profil: data['email']!as String,

    );
  }
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profil': profil

    };
  }
}

