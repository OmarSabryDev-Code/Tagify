import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tagify/cart/items_provider.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/models/item_model.dart';
import 'package:tagify/models/order_model.dart';
import 'package:tagify/orders/order_item.dart';
import '../app_theme.dart';
import '../auth/user_provider.dart';
import '../firebase_functions.dart';
import 'order_item_details.dart';
import 'order_item_details.dart';

class OrderDetails extends StatefulWidget {
  static String routeName = '/orderdetails';



  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late OrderModel currentOrder;

  @override
  Widget build(BuildContext context) {
    // Ensure the order is passed correctly to the screen
    currentOrder = ModalRoute.of(context)!.settings.arguments as OrderModel;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Order Details', style: TextStyle(fontSize: 30)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text('Order ID: ${currentOrder.id}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            //Text('Order Date: ${currentOrder.date}', style: TextStyle(fontSize: 16)),
            //Text('Order Total: \$${currentOrder.total}', style: TextStyle(fontSize: 16)),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'ID: ', // Static text
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Change to your preferred color
                    ),
                  ),
                  TextSpan(
                    text: currentOrder.id, // Dynamic order ID
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Change to your preferred color
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Date: ', // Static text
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Change to your preferred color
                    ),
                  ),
                  TextSpan(
                    text: currentOrder.date, // Dynamic order date
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black, // Change to your preferred color
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Total: ', // Static text
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Change to your preferred color
                    ),
                  ),
                  TextSpan(
                    text: '\$${currentOrder.total}', // Dynamic total value
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black, // Change to your preferred color
                    ),
                  ),
                ],
              ),
            ),



            SizedBox(height: 25),

            Text('Order Items:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Divider(thickness: 1, color: Colors.grey),

            // Ensure you pass the correct items from the order to be displayed
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: currentOrder.items.length,
                itemBuilder: (_, index) {
                  ItemModel item = currentOrder.items[index];

                  // Card displaying each item with CartItem widget
                  return Card(
                    elevation: 5,
                    color: Colors.white,
                    child: OrderDetailsItem(item), // Pass the item model to CartItem
                  );
                },
              ),
            ),
         Container(
           alignment: Alignment.center,
           margin: EdgeInsets.fromLTRB(10, 10, 10, 80),
           child: ElevatedButton(onPressed:(){}, style: ElevatedButton.styleFrom(
             padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
             backgroundColor: Color(0xffce2029),
           ),
             child: const Text('Refund', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),),
           
           
         ) ],
        ),
      ),
    );
  }


  void refundItem() {
    // Implement refund functionality if needed
    }
}