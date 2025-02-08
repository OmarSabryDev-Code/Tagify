import 'package:flutter/material.dart';
import 'package:tagify/models/card_model.dart';
import '../../firebase_functions.dart';

class CardsProvider with ChangeNotifier {
  List<CardModel> cards = [];
  CardModel? selectedCard;

  // Fetch the list of cards for a specific user
  Future<void> getCards(String userId) async {
    try {
      cards = await FirebaseFunctions.getAllCards(userId);

      // Automatically select the first card if none is selected
      if (selectedCard == null && cards.isNotEmpty) {
        selectedCard = cards.first;
      }

      notifyListeners();
    } catch (e) {
      print("Error fetching cards: $e");
    }
  }

  // Set the selected card
  void selectCard(CardModel card) {
    selectedCard = card;
    notifyListeners();
  }
}
