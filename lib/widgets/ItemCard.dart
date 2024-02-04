import 'package:flutter/material.dart';
import 'package:myhb_app/models/item.dart';

class ItemCard extends StatefulWidget {
  Item cardinfo;
   ItemCard({ required this.cardinfo,super.key});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container (
        height: 150
        ,
        child: Column(
          children: [
            Image.network(widget.cardinfo.image!),
            Text(widget.cardinfo.price!)
          ],
        ),
      ),
    );
  }
}
