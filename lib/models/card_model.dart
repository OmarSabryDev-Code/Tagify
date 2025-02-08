import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  String id; // Unique identifier for the card
  String cardNumber; // Card number (as a String to prevent issues with large numbers)
  String name; // Name on the card
  String month; // Expiration month
  String year; // Expiration year
  String cvv; // Security code

  CardModel({
    this.id = '',
    required this.cardNumber,
    required this.name,
    required this.month,
    required this.year,
    required this.cvv,
  });

  CardModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] ?? '',
    cardNumber: json['cardNumber'] ?? '',
    name: json['name'] ?? '',
    month: json['month'] ?? '',
    year: json['year'] ?? '',
    cvv: json['cvv'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'cardNumber': cardNumber,
    'name': name,
    'month': month,
    'year': year,
    'cvv': cvv,
  };
}
