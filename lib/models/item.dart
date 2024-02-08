import 'dart:math';

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
}

List<Item> itemList = generateRandomItemList(15);

List<Item> generateRandomItemList(int itemCount) {
  List<Item> items = [];

  for (int i = 1; i <= itemCount; i++) {
    items.add(Item(
      id: i,
      price: "${Random().nextInt(100) + 50} DZ",
      name: "Item $i",
      rate: Random().nextInt(5) + 1,
      image: "https://example.com/image$i.jpg",
      type: Type.values[Random().nextInt(Type.values.length)],
      colors: generateRandomColors(),
    ));
  }

  return items;
}

List<String> generateRandomColors() {
  List<String> colors = [];

  for (int i = 0; i < Random().nextInt(5) + 1; i++) {
    colors.add("#${Random().nextInt(0xFFFFFF).toRadixString(16).padLeft(6, '0')}");
  }

  return colors;
}
