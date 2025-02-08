import 'package:flutter/material.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/content/item_detaile.dart';
import 'package:tagify/settings/settings_screen.dart';

class Pets extends StatefulWidget {
  static const String routeName = '/Pets';
  @override
  _Pets createState() => _Pets();
}

class _Pets extends State<Pets> {
  Item? selectedItem; // Holds the currently selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Pets',
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
                'assets/images/Pe.jpeg', // Change to your image path
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
                  title: 'Pet Food & Feeding Supplies',
                  items: [
                    Item(
                      imageName: 'assets/images/image62.jpeg',
                      itemName: 'Dry Food',
                      price: '20.99',
                      description: 'Men Basic T-Shirt',
                    ),
                    Item(
                      imageName: 'assets/images/image63.jpeg',
                      itemName: 'Pet Treats',
                      price: '25.99',
                      description: 'Comfortable Pants',
                    ),
                    Item(
                      imageName: 'assets/images/image64.jpeg',
                      itemName: 'Water Bowl',
                      price: '27.99',
                      description: 'Jacket For Cold Weather',
                    ),
                    Item(
                      imageName: 'assets/images/image65.jpg',
                      itemName: 'Water Dispenser',
                      price: '35.99',
                      description: 'Full Set Sleepwear',
                    ),
                    Item(
                      imageName: 'assets/images/image66.jpeg',
                      itemName: 'Pet Food',
                      price: '29.99',
                      description: 'Winter Coat',
                    ),
                  ],
                ),
                _buildSection(
                  context,
                  title: 'Collars, Leashes & Harnesses',
                  items: [
                    Item(
                      imageName: 'assets/images/image67.jpg',
                      itemName: 'Pet Collar',
                      price: '15.99',
                      description: 'Black Sneaker',
                    ),
                    Item(
                      imageName: 'assets/images/image68.jpeg',
                      itemName: 'Pet Leash',
                      price: '17.99',
                      description: 'Comfy Sandals',
                    ),
                    Item(
                      imageName: 'assets/images/image69.jpeg',
                      itemName: 'Pet Tag',
                      price: '10.99',
                      description: 'Slipper',
                    ),
                    Item(
                      imageName: 'assets/images/image70.jpeg',
                      itemName: 'Pet QR Tag',
                      price: '19.99',
                      description: 'Boots For Rough Weather',
                    ),
                    Item(
                      imageName: 'assets/images/image71.jpeg',
                      itemName: 'Harness',
                      price: '21.99',
                      description: 'Brown Loafers',
                    ),
                  ],
                ),
                _buildSection(
                  context,
                  title: 'Toys & Entertainment',
                  items: [
                    Item(
                      imageName: 'assets/images/image72.jpg',
                      itemName: 'Toy',
                      price: '29.99',
                      description: 'Black Fancy Purse',
                    ),
                    Item(
                      imageName: 'assets/images/image73.jpg',
                      itemName: 'Interactive Toy',
                      price: '17.99',
                      description: 'Rayban Sunglasses',
                    ),
                    Item(
                      imageName: 'assets/images/image74.jpeg',
                      itemName: 'Balls',
                      price: '50.99',
                      description: 'Diamond Necklace',
                    ),
                    Item(
                      imageName: 'assets/images/image75.jpeg',
                      itemName: 'Laser',
                      price: '25.99',
                      description: 'Brown Watch',
                    ),
                    Item(
                      imageName: 'assets/images/image76.jpeg',
                      itemName: 'Frizbee',
                      price: '9.99',
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
                  margin: EdgeInsets.only(right: 10, bottom: 25),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
