import 'package:flutter/material.dart';
import 'package:tagify/models/card_model.dart';
import '../../firebase_functions.dart';

class CardsProvider with ChangeNotifier {
  List<CardModel> cards = [];
  CardModel? selectedCard;
  bool isLoading = false; // Added loading state for better UI handling

  // Fetch the list of cards for a specific user
  Future<void> fetchCards(String userId) async {
    isLoading = true;
    notifyListeners();
    try {
      cards = await FirebaseFunctions.getAllCards(userId);

      // Automatically select the first card if none is selected
      if (selectedCard == null && cards.isNotEmpty) {
        selectedCard = cards.first;
      }
    } catch (e) {
      print("Error fetching cards: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> getCards(String userId) async {
    isLoading = true;
    notifyListeners();
    try {
      cards = await FirebaseFunctions.getAllCards(userId);

      // Automatically select the first card if none is selected
      if (selectedCard == null && cards.isNotEmpty) {
        selectedCard = cards.first;
      }

    } catch (e) {
      print("Error fetching cards: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  // Remove a card and update the UI
  Future<void> removeCard(String userId, String cardId) async {
    try {
      await FirebaseFunctions.removeCard(userId, cardId);
      cards.removeWhere((card) => card.id == cardId);

      // If the removed card was selected, reset the selection
      if (selectedCard != null && selectedCard!.id == cardId) {
        selectedCard = cards.isNotEmpty ? cards.first : null;
      }

      notifyListeners();
    } catch (e) {
      print("Error removing card: $e");
    }
  }

  // Set the selected card
  void selectCard(CardModel card) {
    selectedCard = card;
    notifyListeners();
  }

  // Clear selected card
  void clearSelection() {
    selectedCard = null;
    notifyListeners();
  }
}