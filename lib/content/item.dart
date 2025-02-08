import 'package:flutter/cupertino.dart';

class Item extends StatelessWidget{
  String imageName;
  String itemName;
  String price;
  String description;
  Item({
    required this.imageName,
    required this.itemName,
    required this.price,
    required this.description});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
            height: 70,
            child: Image.asset(imageName)),
        Text(itemName),
        Text(price),
      ],
    );
  }

}