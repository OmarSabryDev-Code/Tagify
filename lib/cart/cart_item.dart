import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../auth/user_provider.dart';
import '../firebase_functions.dart';
import '../models/item_model.dart';
import 'items_provider.dart';

class CartItem extends StatefulWidget {
  final ItemModel item;

  CartItem(this.item);

  @override
  State<CartItem> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItem> {
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
          InkWell(
            onTap: () {
              // Handle deletion of the item
              FirebaseFunctions.deleteItemFromFirestore(widget.item.id, userId).then(
                    (_) {
                  if (mounted) {
                    // Refresh the items after deletion
                    Provider.of<ItemsProvider>(context, listen: false).getItems(userId);

                    // Optionally reset data if all items are deleted
                    if (Provider.of<ItemsProvider>(context, listen: false).items.isEmpty) {
                      Provider.of<ItemsProvider>(context, listen: false).resetData();
                    }
                  }
                },
              ).catchError((_) {
                Fluttertoast.showToast(
                  msg: 'Something Went Wrong',
                  toastLength: Toast.LENGTH_LONG,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                );
              });
            },
            child: Icon(
              CupertinoIcons.delete_simple,
              color: AppTheme.primary,
            ), // Icon for delete
          ),
        ],
      ),
    );
  }
}
