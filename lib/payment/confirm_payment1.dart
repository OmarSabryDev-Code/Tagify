import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagify/payment/payment_cards.dart';
import '../app_theme.dart';
import '../firebase_functions.dart';
import '../models/card_model.dart';

class ConfirmPayment1 extends StatelessWidget {
  const ConfirmPayment1({super.key});

  static const String routeName = '/confirmpaying';

  @override
  Widget build(BuildContext context) {
    // Initializing controllers
    TextEditingController numberController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController monthController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController cvvController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Visa',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Text('success')
    );
  }

  bool _validateInputs(String number, String name, String month, String year, String cvv) {
    return number.isNotEmpty && name.isNotEmpty && month.isNotEmpty && year.isNotEmpty && cvv.isNotEmpty;
  }

  Widget _buildCustomTextField({
    required String labelText,
    Color? fillColor,
    Color? textColor,
    Color? borderColor,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
            width: 2.0,
          ),
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      keyboardType: TextInputType.text,
    );
  }
}
