import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../auth/user_provider.dart';
import '../cart/items_provider.dart';
import '../firebase_functions.dart';
import '../models/item_model.dart';

class OrderDetailsItem extends StatefulWidget {
  final ItemModel item;

  OrderDetailsItem(this.item);

  @override
  State<OrderDetailsItem> createState() => _OrderDetailsItemState();
}

class _OrderDetailsItemState extends State<OrderDetailsItem> {
  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;

    return Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(6),
        child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: Image.asset(widget.item.image), // Display item image
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,  // Display item name
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text('${widget.item.price}\$')  // Display item price
                  ],
                ),
              ),
            ],
            ),
        );
    }
}