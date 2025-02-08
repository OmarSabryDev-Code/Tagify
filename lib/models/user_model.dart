import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String name;
  String email;
  bool hasPayment;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.hasPayment = false,
  });

  // Factory method to create UserModel from Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? "Unknown",
      email: user.email ?? "",
    );
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        hasPayment = json['hasPayment'] ?? false;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'hasPayment': hasPayment,
  };
}
