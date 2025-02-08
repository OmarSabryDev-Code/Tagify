import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/app_theme.dart';
import 'package:tagify/models/order_model.dart';
import 'package:tagify/orders/order_details.dart';
import 'package:tagify/orders/orders_provider.dart';

class OrderItem extends StatelessWidget {
  late OrderItem order;
  OrderItem({required OrderItem order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.darkGrey, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '#68944444444', // Display the order ID dynamically
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(width: 10),
          Text('55555'), // Display order date
          SizedBox(width: 30),
          ElevatedButton(
            onPressed: () {
              // Set the selected order in the provider
              Provider.of<OrdersProvider>(context, listen: false).setSelectedOrder(order);
              order = Provider.of<OrdersProvider>(context).selectedOrder!;

              // Navigate to the OrderDetails screen with order details
              Navigator.of(context).pushNamed(
                OrderDetails.routeName,
                arguments: order, // Pass the order object
              );
            },
            child: Text('Details'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
