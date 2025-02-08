import 'package:tagify/content/item.dart';
import 'package:tagify/cart/cart_item.dart';

import 'item_model.dart';

class OrderModel {
  String id;
  String date;
  String total;
  List<ItemModel> items; // Store ItemModel objects

  OrderModel({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
  });

  // Convert Firestore JSON into OrderModel
  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        total = json['total'],
        items = (json['items'] as List)
            .map((itemJson) => ItemModel.fromJson(itemJson)) // Deserialize to ItemModel
            .toList();

  // Convert OrderModel into Firestore JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'total': total,
    'items': items.map((item) => item.toJson()).toList(), // Serialize to ItemModel
  };

  // Convert OrderModel to CartItem list (for UI rendering)
  List<CartItem> toCartItems() {
    return items.map((item) => CartItem(item)).toList(); // Convert ItemModel to CartItem (UI widget)
  }
}
