import 'package:tagify/cart/cart_item.dart';
import 'package:tagify/models/item_model.dart';

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
      : id = json['id']?.toString() ?? 'No ID',  // Ensure it's a string
        date = json['date']?.toString() ?? 'Unknown Date',
        total = json['total']?.toString() ?? '0.0', // Ensure total is a string
        items = (json['items'] as List?)?.map((item) {
          return ItemModel.fromJson(item as Map<String, dynamic>);
        }).toList() ?? [];

  // Convert OrderModel into Firestore JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'total': total,
    'items': items.map((item) => item.toJson()).toList(),
  };

  // Convert OrderModel to CartItem list (for UI rendering)
  List<CartItem> toCartItems() {
    return items.map((item) => CartItem(item)).toList();
  }
}