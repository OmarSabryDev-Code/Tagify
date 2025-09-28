import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tagify/cart/items_provider.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/models/item_model.dart';
import '../app_theme.dart';
import '../auth/user_provider.dart';
import '../firebase_functions.dart';

class ItemDetails extends StatefulWidget{
  static String routeName = '/details';


  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  late Item currentItem;

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    currentItem = ModalRoute.of(context)!.settings.arguments as Item;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Item Description', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  currentItem.imageName, // Use your uploaded image here
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 400,
                ),
              ),
              const SizedBox(height: 60),

              // Title and Description
               Text(
                currentItem.itemName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(height: 8),
               Text(
                currentItem.description,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 50),

              // Stock Information
              const Text(
                'Only 5 left in stock',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 45),

              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  onPressed: () {
                    addItem();
                  },
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addItem(){
    ItemModel item = ItemModel(
        name: currentItem.itemName,
        price: currentItem.price,
        image: currentItem.imageName,
        date: selectedDate);
    String userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    FirebaseFunctions.addItemToFirestore(item, userId).then(
          (_){
        Navigator.of(context).pop();
        Provider.of<ItemsProvider>(context, listen: false).getItems(userId);
        Fluttertoast.showToast(
          msg: 'Item Added Successfully',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.primary,
        );
      },
    )
        .catchError(
            (error)
        {
          Fluttertoast.showToast(
            msg: 'Something Went Wrong',
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
          );
        }
    );
  }
}