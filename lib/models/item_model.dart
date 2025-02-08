import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String id;
  String name;
  String price;
  String image;
  DateTime date;

  ItemModel({
    this.id = '',
    required this.name,
    required this.price,
    required this.image,
    required this.date,
  });

  // Updated fromJson method with correct mapping for 'date' field
  ItemModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] ?? '', // Safe default value for 'id'
    name: json['title'] ?? '', // Default to empty string if 'title' is missing
    price: json['price'] ?? '', // Default to empty string if 'price' is missing
    image: json['image'] ?? '', // Default to empty string if 'image' is missing
    date: (json['date'] as Timestamp).toDate(),
  );

  // Updated toJson method for converting to Firestore-compatible format
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': name, // Firestore expects 'title' instead of 'name'
    'price': price,
    'image': image,
    'date': Timestamp.fromDate(date), // Convert DateTime to Firestore Timestamp
  };
}
