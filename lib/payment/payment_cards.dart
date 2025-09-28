import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/payment/add_card.dart';
import '../app_theme.dart';
import '../auth/user_provider.dart';
import '../cart/items_provider.dart';
import '../firebase_functions.dart';
import '../models/item_model.dart';
import 'card_item.dart';
import 'card_provider.dart';
import 'confirm_payment1.dart';

class PaymentCards extends StatelessWidget {
  const PaymentCards({super.key});

  static const String routeName = '/confirmpay';

  @override
  Widget build(BuildContext context) {
    final cardsProvider = Provider.of<CardsProvider>(context);
    final selectedCard = cardsProvider.selectedCard;
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final double total = args['total'];
    final String userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Payment',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                future: cardsProvider.cards.isEmpty
                    ? cardsProvider.getCards(userId)
                    : Future.value(cardsProvider.cards),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred while fetching cards.', style: TextStyle(fontSize: 16, color: Colors.red)));
                  } else {
                    return cardsProvider.cards.isEmpty
                        ? const Center(child: Text('No cards available.', style: TextStyle(fontSize: 18, color: Colors.black)))
                        : ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: cardsProvider.cards.length,
                      itemBuilder: (_, index) => CardItem(cardsProvider.cards[index]),
                    );
                  }
                },
              ),
            ),
            const Spacer(),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.all(10),
              width: 105,
              height: 90,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddCardScreens.routeName);
                },
                child: Image.asset('assets/images/Plus.png'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: AppTheme.black,
                ),
              ),
            ),
            const SizedBox(height:10),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
                ],


              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Price:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                  Text('\$$total', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedCard != null) {
                    try {
                      final List<ItemModel> cartItems = args['items'];
                      await FirebaseFunctions.createOrder(userId, total, cartItems, selectedCard);
                      final itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
                      await itemsProvider.clearUserItems(userId);
                      Navigator.of(context).pushReplacementNamed(ConfirmPayment1.routeName);
                    } catch (error) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Payment Error'),
                          content: const Text('An error occurred while processing your payment.'),
                          actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Okay'))],
                        ),
                      );
                      print(error);
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Card Selection Required'),
                        content: const Text('Please select a payment card to proceed with the payment.'),
                        actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Okay'))],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                  backgroundColor: AppTheme.primary,
                ),
                child: const Text('Confirm Payment', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}