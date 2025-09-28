import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/firebase_functions.dart';
import 'package:tagify/models/card_model.dart';
import 'package:tagify/payment/card_provider.dart';
import '../app_theme.dart';
import '../auth/user_provider.dart';

class CardItem extends StatefulWidget {
  final CardModel card;

  const CardItem(this.card, {super.key});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    final cardsProvider = Provider.of<CardsProvider>(context);
    bool isSelected = widget.card == cardsProvider.selectedCard;

    return GestureDetector(
      onTap: () {
        cardsProvider.selectCard(widget.card); // Set selected card
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary.withOpacity(0.3) : AppTheme.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
        ),
        width: 350,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Card Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/images/visaa.jpg', width: 90, height: 50),
            ),
            const SizedBox(width: 10),

            // Card Number (Last 4 Digits)
            Expanded(
              child: Text(
                '**** ${widget.card.cardNumber.substring(widget.card.cardNumber.length - 4)}',
                style: TextStyle(
                  color: isSelected ? AppTheme.black : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 3),
            // Selected Check Icon
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.green, size: 28),

            // Delete Icon
            IconButton(
              icon: const Icon(CupertinoIcons.trash, color: Colors.redAccent, size: 25),
              onPressed: () => _deleteCard(context, cardsProvider),
            ),
          ],
        ),
      ),
    );
  }

  // Handle Card Deletion
  void _deleteCard(BuildContext context, CardsProvider cardsProvider) {
    String userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    String cardId = widget.card.id;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Card'),
          content: const Text('Are you sure you want to delete this card?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  cardsProvider.removeCard(userId, cardId); // Remove card from provider state

                  // If the deleted card was selected, clear selection
                  if (cardsProvider.selectedCard == widget.card) {
                    cardsProvider.clearSelection();
                  }

                  Navigator.of(context).pop();
                } catch (error) {
                  // Handle deletion error
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Failed to delete the card. Please try again.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Okay'),
                        ),
                      ],
                    ),
                  );
                  print(error);
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
