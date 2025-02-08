import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tagify/orders/order_item.dart';
import 'package:tagify/profile/customer_support.dart';
import 'package:tagify/profile/profile_provider.dart';

import '../auth/log_in.dart';
import '../auth/user_provider.dart';
import '../cart/items_provider.dart';
import '../firebase_functions.dart';
import '../models/profile_model.dart';
import '../orders/orders_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path); // Save the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    List<OrderItem> orders = ordersProvider.orders.cast<OrderItem>();
    String userName = Provider.of<UserProvider>(context).currentUser!.name;
    String userId = Provider.of<UserProvider>(context).currentUser?.id ?? ''; // Default to an empty string if null
    ProfileModel? profileProvider = Provider.of<ProfileProvider>(context).profile;

    // Check if profileProvider is null or use default values
    String name = profileProvider?.name ?? userName;
    String birthdate = profileProvider?.birthdate ?? 'Not Available';
    String bio = profileProvider?.bio ?? 'No bio available';
    String profileImage = profileProvider?.image ?? 'assets/images/D.jpg';

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 145),
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 70),
                  InkWell(
                    onTap: () {
                      FirebaseFunctions.logout();
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                      Provider.of<ItemsProvider>(context, listen: false).resetData();
                      Provider.of<UserProvider>(context, listen: false).updateUser(null);
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Top Section (Blue Background)
          Container(
            color: Colors.blue,
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,  // Add onTap to change profile image
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: _profileImage != null
                          ? FileImage(File(_profileImage!.path))
                          : (profileImage.startsWith('http')
                          ? NetworkImage(profileImage) as ImageProvider
                          : File(profileImage).existsSync()
                          ? FileImage(File(profileImage))
                          : AssetImage('assets/images/D.jpg') as ImageProvider),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userId,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  birthdate,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  bio,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Bottom Section (White Background)
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 140, vertical: 1),
                      child: Text(
                        "History",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 1, height: 1, color: Colors.grey[300]),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    child: Expanded(
                      child: Consumer<OrdersProvider>(
                        builder: (context, ordersProvider, child) {
                          final orderList = ordersProvider.orders; // Fetch orders
                          OrderItem? selectedOrder = ordersProvider.selectedOrder;

                          if (orderList.isEmpty) {
                            return Center(
                              child: Text("No Order History", style: TextStyle(fontSize: 18, color: Colors.grey)),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              selectedOrder = orderList[index]; // Update selected order
                              return Card(
                                shadowColor: Colors.transparent,
                                borderOnForeground: false,
                                color: Colors.white,
                                child: OrderItem(order: orderList[index]), // Pass order object
                              );
                            },
                          );
                        },
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(CustomerSupport.routeName);
        },
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/cs.png', height: 40, width: 40),
      ),
    );
  }

  Widget buildPurchasedItem(String title, String time, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Date: ${DateTime.now().toLocal().toString().split(' ')[0]}",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Refund requested for $title')),

                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(100, 30),
                  padding: EdgeInsets.zero,
                ),
                child: Text('Refund', style: TextStyle(fontSize: 17)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}