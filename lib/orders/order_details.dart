import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tagify/cart/items_provider.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/models/item_model.dart';
import 'package:tagify/orders/order_item.dart';
import '../app_theme.dart';
import '../auth/user_provider.dart';
import '../firebase_functions.dart';

class OrderDetails extends StatefulWidget{
  static String routeName = '/orderdetails';

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late OrderItem currentOrder;

  @override
  Widget build(BuildContext context) {
    currentOrder = ModalRoute.of(context)!.settings.arguments as OrderItem;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details', style: TextStyle(fontSize: 24),),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
    );
  }
}