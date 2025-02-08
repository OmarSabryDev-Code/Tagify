import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/models/item_model.dart';
import 'package:tagify/orders/order_item.dart';
import '../../firebase_functions.dart';
import '../models/order_model.dart';


class OrdersProvider with ChangeNotifier{
  List<OrderItem> orders = [];
  DateTime selectedDate = DateTime.now();
  OrderItem? selectedOrder;

  void setSelectedOrder(OrderItem order){
    selectedOrder = order;
    notifyListeners();
  }
}