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

  UserProvider? _userProvider;
  ItemsProvider? _itemsProvider;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _userProvider = Provider.of<UserProvider>(context, listen: false);
      _itemsProvider = Provider.of<ItemsProvider>(context, listen: false);

      if (_userProvider != null) {
        _userProvider!.addListener(_onUserChanged);
      }
      if (_itemsProvider != null) {
        _itemsProvider!.addListener(_onItemsChanged);
      }

      _loadCartItems();
      _isInitialized = true; // Ensure this runs only once
    }
  }

  @override
  void dispose() {
    _userProvider?.removeListener(_onUserChanged);
    _itemsProvider?.removeListener(_onItemsChanged);
    super.dispose();
  }

  void _onUserChanged() {
    _loadCartItems();
  }

  void _onItemsChanged() {
    fetchTotalPrice();
  }

  Future<void> _loadCartItems() async {
    if (_userProvider?.currentUser == null) {
      setState(() {
        errorMessage = 'No user logged in.';
      });
      return;
    }

    String userId = _userProvider!.currentUser!.id;
    try {
      await _itemsProvider!.getItems(userId);
      setState(() {}); // Force UI update after items are fetched
      fetchTotalPrice();
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load cart items. Please try again later.';
      });
    }
  }

  Future<void> fetchTotalPrice() async {
    if (_userProvider?.currentUser == null) return;

    String userId = _userProvider!.currentUser!.id;
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
    final itemsProvider = Provider.of<ItemsProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final userId = userProvider.currentUser?.id ?? '';
    final hasCards = userProvider.currentUser?.hasPayment ?? false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100, // Increased height
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 38),
        ),
        centerTitle: true,
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
                  itemCount: itemsProvider.items.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: Colors.white,
                      child: CartItem(itemsProvider.items[index]),
                    );
                  },
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
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      PaymentCards.routeName,
                      arguments: {
                        'total': total,
                        'cards': hasCards,
                        'items': itemsProvider.items,
                      },
                    );
                  },
                  child: Text(
                    'Continue to payment',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
        ),
    );
    }
}