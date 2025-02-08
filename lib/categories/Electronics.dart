import 'package:flutter/material.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/content/item_detaile.dart';
import 'package:tagify/settings/settings_screen.dart';

class Electronics extends StatefulWidget {
  static const String routeName = '/Electronics';
  @override
  _Electronics createState() => _Electronics();
}

class _Electronics extends State<Electronics> {
  Item? selectedItem; // Holds the currently selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Electronics',
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
                'assets/images/Techno.jpg', // Change to your image path
                fit: BoxFit.cover,
              ),
            ),
            // Semi-transparent overlay for better readability
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.8), // Adjust opacity as needed
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
                  title: 'Mobile & Accessories',
                  items: [
                    Item(
                      imageName: 'assets/images/image32.jpeg',
                      itemName: 'IPhone ',
                      price: '830.99',
                      description: 'IPhone 14 Pro Max',
                    ),
                    Item(
                      imageName: 'assets/images/image33.jpg',
                      itemName: 'Tablet',
                      price: '1099.99',
                      description: 'Samsung Tablet',
                    ),
                    Item(
                      imageName: 'assets/images/image34.jpeg',
                      itemName: 'Smart Watch',
                      price: '799.99',
                      description: 'New Gen Smart Watch',
                    ),
                    Item(
                      imageName: 'assets/images/image35.jpeg',
                      itemName: 'Power Bank',
                      price: '300.99',
                      description: '20W Power Bank',
                    ),
                    Item(
                      imageName: 'assets/images/image36.jpeg',
                      itemName: 'Charger',
                      price: '120.99',
                      description: 'White Charger',
                    ),
                  ],
                ),
                _buildSection(
                  context,
                  title: 'Computers & Laptops',
                  items: [
                    Item(
                      imageName: 'assets/images/image37.jpeg',
                      itemName: 'Laptop',
                      price: '499.99',
                      description: 'Next Gen Laptop',
                    ),
                    Item(
                      imageName: 'assets/images/image38.jpg',
                      itemName: 'Monitor',
                      price: '399.99',
                      description: 'White Monitor',
                    ),
                    Item(
                      imageName: 'assets/images/image39.jpg',
                      itemName: 'Hard Drive',
                      price: '49.99',
                      description: 'Black Hard Drive',
                    ),
                    Item(
                      imageName: 'assets/images/image40.jpeg',
                      itemName: 'Keyboard',
                      price: '199.99',
                      description: 'Customized Keyboard',
                    ),
                    Item(
                      imageName: 'assets/images/image41.jpeg',
                      itemName: 'Mouse',
                      price: '99.99',
                      description: 'RGB Mouse',
                    ),
                  ],
                ),
                _buildSection(
                  context,
                  title: 'Gaming & Consoles',
                  items: [
                    Item(
                      imageName: 'assets/images/image42.jpeg',
                      itemName: 'Playstation 4',
                      price: '399.99',
                      description: 'Sony Playstation 4 ',
                    ),
                    Item(
                      imageName: 'assets/images/image43.jpeg',
                      itemName: 'Xbox',
                      price: '499.99',
                      description: 'Xbox 360',
                    ),
                    Item(
                      imageName: 'assets/images/image44.jpeg',
                      itemName: 'Nintendo',
                      price: '299.99',
                      description: 'Nintendo Switch',
                    ),
                    Item(
                      imageName: 'assets/images/image45.jpeg',
                      itemName: 'VR Headset',
                      price: '599.99',
                      description: 'White Virtual Reality Headset',
                    ),
                    Item(
                      imageName: 'assets/images/image46.jpeg',
                      itemName: 'Gaming Headset',
                      price: '149.99',
                      description: 'Hp Gaming Headset',
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
