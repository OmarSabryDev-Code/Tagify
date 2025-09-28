import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../firebase_functions.dart';
import '../models/card_model.dart';
import 'card_provider.dart';

class AddCardScreens extends StatelessWidget {
  const AddCardScreens({super.key});

  static const String routeName = '/addcard';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomTextField(
              labelText: 'Card Number',
              fillColor: AppTheme.grey,
              textColor: AppTheme.darkGrey,
              borderColor: AppTheme.lightGrey,
              controller: numberController,
            ),
            const SizedBox(height: 16.0),
            _buildCustomTextField(
              labelText: 'Name on Card',
              fillColor: AppTheme.grey,
              textColor: AppTheme.darkGrey,
              borderColor: AppTheme.lightGrey,
              controller: nameController,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _buildCustomTextField(
                    labelText: 'MM',
                    fillColor: AppTheme.grey,
                    textColor: AppTheme.darkGrey,
                    borderColor: AppTheme.lightGrey,
                    controller: monthController,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildCustomTextField(
                    labelText: 'YYYY',
                    fillColor: AppTheme.grey,
                    textColor: AppTheme.darkGrey,
                    borderColor: AppTheme.lightGrey,
                    controller: yearController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildCustomTextField(
              labelText: 'Security Code (CVV/CVC)',
              fillColor: AppTheme.grey,
              textColor: AppTheme.darkGrey,
              borderColor: AppTheme.lightGrey,
              controller: cvvController,
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final card = CardModel(
                    cardNumber: numberController.text.trim(),
                    name: nameController.text.trim(),
                    month: monthController.text.trim(),
                    year: yearController.text.trim(),
                    cvv: cvvController.text.trim(),
                  );

                  final userId = FirebaseAuth.instance.currentUser!.uid;
                  await FirebaseFunctions.addCardPayment(userId, card);

                  // Refresh cards list
                  final cardsProvider = Provider.of<CardsProvider>(context, listen: false);
                  await cardsProvider.getCards(userId);

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Card Added Successfully"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  Navigator.of(context).pop();
                },


                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  backgroundColor: AppTheme.primary,
                ),
                child: const Text(
                  'Add Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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