import 'package:cloud_firestore/cloud_firestore.dart';

enum Type { All, Chair, Table, Sofa, Bed, Lamb }

class Item {
  String? id;
  final String? price;
  final String? name;
  final int? rate;
  final String? image;
  final Type? type;
  final List<String>? colors;
  final List<String>? files;
  final String? description;
  final bool? isfavorite;
  Item({
    this.price,
    this.name,
    this.rate,
    this.image,
    this.colors,
    this.id,
    this.type,
    this.files,
    this.description,
    this.isfavorite,
  });

  factory Item.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Item(
      id: data['id'],
      price: data['price'] as String?,
      name: data['name'] as String?,
      rate: data['rate'] as int?,
      image: data['image']! as String,
      type: _parseType(data['type'] as String?),
      colors: (data['colors'] as List?)?.cast<String>(),
      files: (data['files'] as List?)?.cast<String>(),
      description: data['description'] as String?,
      isfavorite: data['isfavorite'] as bool,
    );
  }
  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
      id: data['id'],
      price: data['price'] as String?,
      name: data['name'] as String?,
      rate: data['rate'] as int?,
      image: data['image'] as String?,
      type: _parseType(data['type'] as String?),
      colors: (data['colors'] as List?)?.cast<String>(),
      files: (data['files'] as List?)?.cast<String>(),
      description: data['description'] as String?,
      isfavorite: data['isfavorite'] as bool,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'price': price,
      'name': name,
      'rate': rate,
      'image': image,
      'type': type?.toString().split('.').last,
      'colors': colors as List<String?>,
      'files': files as List<String?>,
      'description': description,
      'isfavorite': isfavorite
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
      case 'Sofa':
        return Type.Sofa;
      case 'Lamb':
        return Type.Lamb;
      case 'Bed':
        return Type.Bed;
      default:
        return null;
    }
  }
}
