import 'package:flutter/material.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/content/item_detaile.dart';
import 'package:tagify/settings/settings_screen.dart';

class Fashion extends StatefulWidget {
  static const String routeName = '/Fashion';
  @override
  _Fashion createState() => _Fashion();
}

class _Fashion extends State<Fashion> {
  Item? selectedItem; // Holds the currently selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFFD9E4F4),
        elevation: 0,
        title: Text(
          'Market',
          style: TextStyle(
            fontSize: 38,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Filter',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
      // Background Image
      Positioned.fill(
      child: Image.asset(
        'assets/images/HH.jpeg', // Change to your image path
        fit: BoxFit.cover,
      ),
    ),
    // Semi-transparent overlay for better readability
    Positioned.fill(
    child: Container(
    color: Colors.white.withOpacity(0.6), // Adjust opacity as needed
    ),
    ),
    // Content
      ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          _buildSection(
            context,
            title: 'Clothing',
            items: [
              Item(
                imageName: 'assets/images/Image17.jpeg',
                itemName: 'T Shirt ',
                price: '20.99',
                description: 'Men Basic T-Shirt',
              ),
              Item(
                imageName: 'assets/images/image18.jpeg',
                itemName: 'Bottom',
                price: '25.99',
                description: 'Comfortable Pants',
              ),
              Item(
                imageName: 'assets/images/image19.jpeg',
                itemName: 'Jacket',
                price: '27.99',
                description: 'Jacket For Cold Weather',
              ),
              Item(
                imageName: 'assets/images/image20.jpeg',
                itemName: 'Sleepwear',
                price: '35.99',
                description: 'Full Set Sleepwear',
              ),
              Item(
                imageName: 'assets/images/image21.jpeg',
                itemName: 'Coat',
                price: '29.99',
                description: 'Winter Coat',
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Footwear',
            items: [
              Item(
                imageName: 'assets/images/image22.jpeg',
                itemName: 'Sneaker',
                price: '15.99',
                description: 'Black Sneaker',
              ),
              Item(
                imageName: 'assets/images/image23.jpeg',
                itemName: 'Sandals',
                price: '17.99',
                description: 'Comfy Sandals',
              ),
              Item(
                imageName: 'assets/images/image24.jpeg',
                itemName: 'Slippers',
                price: '10.99',
                description: 'Slipper',
              ),
              Item(
                imageName: 'assets/images/image25.jpeg',
                itemName: 'Boots',
                price: '19.99',
                description: 'Boots For Rough Weather',
              ),
              Item(
                imageName: 'assets/images/image26.jpeg',
                itemName: 'Loafers',
                price: '21.99',
                description: 'Brown Loafers',
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Accessories',
            items: [
              Item(
                imageName: 'assets/images/image27.jpeg',
                itemName: 'Purse',
                price: '29.99',
                description: 'Black Fancy Purse',
              ),
              Item(
                imageName: 'assets/images/image28.jpeg',
                itemName: 'Sunglasses',
                price: '17.99',
                description: 'Rayban Sunglasses',
              ),
              Item(
                imageName: 'assets/images/image29.jpeg',
                itemName: 'Necklace',
                price: '50.99',
                description: 'Diamond Necklace',
              ),
              Item(
                imageName: 'assets/images/image30.jpeg',
                itemName: 'Watch',
                price: '25.99',
                description: 'Brown Watch',
              ),
              Item(
                imageName: 'assets/images/image31.jpeg',
                itemName: 'Belt',
                price: '22.99',
                description: 'Black Leather Belt',
              ),
            ],
          ),
        ],
      ),
    ],
      )
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Item> items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 0.5, color: Colors.grey, offset: Offset(0.5, 0.5))],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedItem = item;
                        Navigator.of(context).pushNamed(ItemDetails.routeName, arguments: selectedItem);
                      });
                    },
                    child: item,
                  ),
                  color: Colors.white,
                  elevation: 6,
                  margin: EdgeInsets.only(right: 10,bottom: 25),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
