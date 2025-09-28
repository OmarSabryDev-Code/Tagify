import 'package:flutter/material.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/content/item_detaile.dart';
import 'package:tagify/settings/settings_screen.dart';

class Arts extends StatefulWidget {
  static const String routeName = '/Arts';
  @override
  _Arts createState() => _Arts();
}

class _Arts extends State<Arts> {
  Item? selectedItem; // Holds the currently selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,

        elevation: 0,
        title: Text(
          'Arts & Crafts',
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
              'assets/images/Arts.jpeg', // Change to your image path
              fit: BoxFit.cover,
            ),
          ),

          // Semi-transparent overlay for better readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2), // Adjust opacity as needed
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
                    fillColor: Colors.white,
                  ),
                ),
              ),
              _buildSection(
                context,
                title: 'Painting & Drawing',
                items: [
                  Item(
                    imageName: 'assets/images/image77.jpeg',
                    itemName: 'Acrylic Paints',
                    price: '11.99',
                    description: 'Mosturizer For Oily skin',
                  ),
                  Item(
                    imageName: 'assets/images/image78.jpeg',
                    itemName: 'Watercolors',
                    price: '8.99',
                    description: 'Face Cleanser',
                  ),
                  Item(
                    imageName: 'assets/images/image79.jpeg',
                    itemName: 'Sketchbook',
                    price: '15.99',
                    description: 'Sun Screen For Protection',
                  ),
                  Item(
                    imageName: 'assets/images/image80.jpeg',
                    itemName: ' Colored Pencils ',
                    price: '19.99',
                    description: 'Skin Care Face Mask',
                  ),
                  Item(
                    imageName: 'assets/images/image81.jpeg',
                    itemName: 'Charcoal',
                    price: '10.99',
                    description: 'Eye Cream For Dark Circles',
                  ),
                ],
              ),
              _buildSection(
                context,
                title: 'DIY & Craft Supplies',
                items: [
                  Item(
                    imageName: 'assets/images/image82.jpg',
                    itemName: 'Craft Paper',
                    price: '13.99',
                    description: 'Fit me Dewy + Smooth Liquid',
                  ),
                  Item(
                    imageName: 'assets/images/image83.jpg',
                    itemName: 'Tapes',
                    price: '18.99',
                    description: 'Brown Lipstick',
                  ),
                  Item(
                    imageName: 'assets/images/image84.jpeg',
                    itemName: 'Glue',
                    price: '12.99',
                    description: 'Blot Powder',
                  ),
                  Item(
                    imageName: 'assets/images/image85.jpg',
                    itemName: 'Scissors',
                    price: '16.99',
                    description: 'Lash Sensational Washable Mascara',
                  ),
                  Item(
                    imageName: 'assets/images/image86.jpeg',
                    itemName: ' Heart Stickers ',
                    price: '11.99',
                    description: 'Infalliable Full Wear Concealer',
                  ),
                ],
              ),
              _buildSection(
                context,
                title: 'Sculpting & Modeling',
                items: [
                  Item(
                    imageName: 'assets/images/image87.jpg',
                    itemName: ' Clay Tools ',
                    price: '25.99',
                    description: 'Generic Value Shampoo',
                  ),
                  Item(
                    imageName: 'assets/images/image88.jpg',
                    itemName: ' Wood Carving Kit ',
                    price: '8.99',
                    description: 'Exellence Hair Dye Cream',
                  ),
                  Item(
                    imageName: 'assets/images/image89.jpg',
                    itemName: ' 3D Printing Supplies ',
                    price: '30.99',
                    description: 'Professional Hair Straightener',
                  ),
                  Item(
                    imageName: 'assets/images/image90.jpeg',
                    itemName: ' Pottery Ribbons ',
                    price: '39.99',
                    description: 'Hair Styling Curler',
                  ),
                  Item(
                    imageName: 'assets/images/image91.jpeg',
                    itemName: ' Rolling Pins ',
                    price: '15.99',
                    description: '99% Natural Hair Oil',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
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
              color: Colors.white,
              shadows: [Shadow(blurRadius: 0.6, color: Colors.black, offset: Offset(0.5, 0.5))],
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
                  elevation: 2,
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
