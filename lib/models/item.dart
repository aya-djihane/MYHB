import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

enum Type { Chair, Table, Armchair, Bed }

class Item {
  int? id;
  final String? price;
  final String? name;
  final int? rate;
  final String? image;
  final Type? type;
  final List<String>? colors;
  final String? description;

  Item({
    this.price,
    this.name,
    this.rate,
    this.image,
    this.colors,
    this.id,
    this.type,
    this.description
  });
  // factory Item.fromJson(Map<String, dynamic> json) {
  //   return Item(
  //     id: json['id'] as int?,
  //     price: json['price'] as String?,
  //     name: json['name'] as String?,
  //     rate: json['rate'] as int?,
  //     // 'image' is a DocumentReference
  //     image: json['image'] as String?,
  //     type: _parseType(json['type'] as String?),
  //     colors: (json['colors'] as List?)?.cast<String>(),
  //     description: json['description'] as String?,
  //   );
  // }
  factory Item.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Item(
      id: data['id'] as int?,
      price: data['price'] as String?,
      name: data['name'] as String?,
      rate: data['rate'] as int?,
      image: data['image']!as String,
      type: _parseType(data['type'] as String?),
      colors: (data['colors'] as List?)?.cast<String>(),
      description: data['description'] as String?,
    );
  }
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'price': price,
      'name': name,
      'rate': rate,
      'image': image,
      'type': type?.toString().split('.').last, // Convert Type enum to String
      'colors': colors,
      'description': description,
    };
  }
  static Type? _parseType(String? typeString) {
    if (typeString == null) {
      return null;
    }
    switch (typeString) {
      case 'Chair':
        return Type.Chair;
      case 'Table':
        return Type.Table;
      case 'Armchair':
        return Type.Armchair;
      case 'Bed':
        return Type.Bed;
      default:
        return null;
    }
  }


}


// List<Item> itemList = generateRandomItemList(15);

// List<Item> generateRandomItemList(int itemCount) {
//   List<Item> items = [];
//
//   for (int i = 1; i <= itemCount; i++) {
//     items.add(Item(
//       id: i,
//       price: "${Random().nextInt(100) + 50} DZ",
//       name: "Item $i",
//       rate: Random().nextInt(5) + 1,
//       image: "https://example.com/image$i.jpg",
//       type: Type.values[Random().nextInt(Type.values.length)],
//       colors: generateRandomColors(),
//     ));
//   }
//
//   return items;
// }

List<String> generateRandomColors() {
  List<String> colors = [];

  for (int i = 0; i < Random().nextInt(5) + 1; i++) {
    colors.add("#${Random().nextInt(0xFFFFFF).toRadixString(16).padLeft(6, '0')}");
  }

  return colors;
}
