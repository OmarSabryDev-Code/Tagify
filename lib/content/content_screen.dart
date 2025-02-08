import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagify/cart/cart.dart';
import 'package:tagify/categories/categories.dart';
import 'package:tagify/content/home_tab.dart';
import 'package:tagify/profile/profile_page.dart';
import 'package:tagify/settings/settings_screen.dart';

class ContentPage extends StatefulWidget {
  static const String routeName = '/content';
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int _currentIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    SettingsScreen(),
    Categories(),
    Cart(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}