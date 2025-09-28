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
import '../models/order_model.dart';
import '../orders/orders_provider.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/ProfilePage'; // Added Route Name

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;




  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final userId = Provider.of<UserProvider>(context, listen: false).currentUser?.id ?? '';
      if (userId.isNotEmpty) {
        Provider.of<OrdersProvider>(context, listen: false).fetchOrdersByUserId(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    List<OrderModel> orders = ordersProvider.orders;
    String userName = Provider.of<UserProvider>(context).currentUser!.name;
    String userId = Provider.of<UserProvider>(context).currentUser?.id ?? '';
    ProfileModel? profileProvider = Provider.of<ProfileProvider>(context).profile;

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
                    SizedBox(width: 105),
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 50),
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
            Container(
              color: Colors.blue,
              padding: EdgeInsets.only(top: 30, bottom: 15),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
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
                  SizedBox(height: 2),
                  Text(name, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  Text(userId, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(birthdate, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(bio, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("History", style: TextStyle(fontSize: 28, color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                    Divider(thickness: 1, height: 1, color: Colors.grey[300]),
                    Expanded(
                      child: Consumer<OrdersProvider>(
                        builder: (context, ordersProvider, child) {
                          final orderList = ordersProvider.orders;

                          if (orderList.isEmpty) {
                            return Center(
                              child: Text("No Order History", style: TextStyle(fontSize: 18, color: Colors.grey)),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            itemCount: orderList.length,
                            itemBuilder: (context, index) {
                              return OrderItem(order: orderList[index]);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (orders.isNotEmpty) {
                Navigator.of(context).pushNamed(CustomerSupport.routeName, arguments: orders[0]);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No orders to support.")));
              }
            },
            backgroundColor: Colors.white,
            child: Image.asset('assets/images/cs.png', height: 40, width: 40),
            ),
        );
    }
}