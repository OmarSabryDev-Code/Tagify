import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/cart/cart_item.dart';
import 'package:tagify/cart/items_provider.dart';
import 'package:tagify/firebase_functions.dart';
import 'package:tagify/payment/payment_cards.dart';

import '../app_theme.dart';
import '../auth/user_provider.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double total = 0.0;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Add listener to itemsProvider for item changes
    Provider.of<ItemsProvider>(context, listen: false).addListener(_onItemsChanged);
    _loadCartItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch price whenever the screen rebuilds or items change
    fetchTotalPrice();
  }

  @override
  void dispose() {
    // Clean up the listener when the widget is disposed
    Provider.of<ItemsProvider>(context, listen: false).removeListener(_onItemsChanged);
    super.dispose();
  }

  void _onItemsChanged() {
    fetchTotalPrice();
  }

  // Fetch the cart items from Firebase (or local storage) on screen load
  Future<void> _loadCartItems() async {
    String userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    try {
      await Provider.of<ItemsProvider>(context, listen: false).getItems(userId);
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load cart items. Please try again later.';
      });
    }
  }

  Future<void> fetchTotalPrice() async {
    String userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    try {
      double fetchedTotal = await FirebaseFunctions.calculateTotalPrice(userId);
      setState(() {
        total = fetchedTotal;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to fetch total price. Please try again later.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ItemsProvider itemsProvider = Provider.of<ItemsProvider>(context);
    String userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    bool hasCards = Provider.of<UserProvider>(context, listen: false).currentUser!.hasPayment;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cart',
          style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Filter',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (_, index) {
                return Card(
                  color: Colors.white,
                  child: CartItem(
                    itemsProvider.items[index],
                  ),
                );
              },
              itemCount: itemsProvider.items.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(PaymentCards.routeName, arguments: {
                'total': total,
                'cards': hasCards,
                'items': itemsProvider.items,
              });
            },
            child: Text(
              'Continue to payment',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppTheme.white, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/visa.png', // Visa Logo
                    ),
                    const SizedBox(height: 8),
                    const Text('InstaPay', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/insta.png', // Mastercard Logo
                    ),
                    const SizedBox(height: 8),
                    const Text('Visa', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/vodaphone.png', // Vodafone Cash Logo
                    ),
                    const SizedBox(height: 8),
                    const Text('Vodafone Cash', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
