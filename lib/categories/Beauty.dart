import 'package:flutter/material.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/content/item_detaile.dart';
import 'package:tagify/settings/settings_screen.dart';

class Beauty extends StatefulWidget {
  static const String routeName = '/Beauty';
  @override
  _Beauty createState() => _Beauty();
}

class _Beauty extends State<Beauty> {
  Item? selectedItem; // Holds the currently selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xffeae6e6),

        elevation: 0,
        title: Text(
          'Beauty',
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
              'assets/images/MUP.jpeg', // Change to your image path
              fit: BoxFit.cover,
            ),
          ),

          // Semi-transparent overlay for better readability
          Positioned.fill(
            child: Container(
              color: Colors.grey.withOpacity(0.2), // Adjust opacity as needed
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
                title: 'Skin Care',
                items: [
                  Item(
                    imageName: 'assets/images/image1.jpg',
                    itemName: 'Moisturizer',
                    price: '11.99',
                    description: 'Mosturizer For Oily skin',
                  ),
                  Item(
                    imageName: 'assets/images/image2.png',
                    itemName: 'Cleanser',
                    price: '8.99',
                    description: 'Face Cleanser',
                  ),
                  Item(
                    imageName: 'assets/images/image3.jpg',
                    itemName: 'Sun Screen',
                    price: '15.99',
                    description: 'Sun Screen For Protection',
                  ),
                  Item(
                    imageName: 'assets/images/image5.png',
                    itemName: 'Face Mask',
                    price: '19.99',
                    description: 'Skin Care Face Mask',
                  ),
                  Item(
                    imageName: 'assets/images/image6.jpg',
                    itemName: 'Eye Cream',
                    price: '10.99',
                    description: 'Eye Cream For Dark Circles',
                  ),
                ],
              ),
              _buildSection(
                context,
                title: 'Makeup',
                items: [
                  Item(
                    imageName: 'assets/images/image7.jpeg',
                    itemName: 'Foundation',
                    price: '13.99',
                    description: 'Fit me Dewy + Smooth Liquid',
                  ),
                  Item(
                    imageName: 'assets/images/image8.jpg',
                    itemName: 'Lipstick',
                    price: '18.99',
                    description: 'Brown Lipstick',
                  ),
                  Item(
                    imageName: 'assets/images/image9.jpeg',
                    itemName: 'Eye Shadow',
                    price: '12.99',
                    description: 'Blot Powder',
                  ),
                  Item(
                    imageName: 'assets/images/image10.jpeg',
                    itemName: 'Mascara',
                    price: '16.99',
                    description: 'Lash Sensational Washable Mascara',
                  ),
                  Item(
                    imageName: 'assets/images/image11.jpeg',
                    itemName: 'Concealer',
                    price: '11.99',
                    description: 'Infalliable Full Wear Concealer',
                  ),
                ],
              ),
              _buildSection(
                context,
                title: 'Haircare',
                items: [
                  Item(
                    imageName: 'assets/images/image12.jpg',
                    itemName: 'Shampoo',
                    price: '25.99',
                    description: 'Generic Value Shampoo',
                  ),
                  Item(
                    imageName: 'assets/images/image13.jpeg',
                    itemName: 'Hair Dyes',
                    price: '8.99',
                    description: 'Exellence Hair Dye Cream',
                  ),
                  Item(
                    imageName: 'assets/images/image14.jpeg',
                    itemName: 'Straightener',
                    price: '30.99',
                    description: 'Professional Hair Straightener',
                  ),
                  Item(
                    imageName: 'assets/images/image15.jpeg',
                    itemName: 'Curler',
                    price: '39.99',
                    description: 'Hair Styling Curler',
                  ),
                  Item(
                    imageName: 'assets/images/image16.jpeg',
                    itemName: 'Hair Oil',
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
