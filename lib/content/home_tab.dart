import 'package:flutter/material.dart';
//import 'package:tagify/Qr%20Code/qr_code.dart';
import 'package:tagify/Scanner/barcode_scanner_page.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/content/item_detaile.dart';
import 'package:tagify/settings/settings_screen.dart';

import '../Scanner/barcode_generator_page.dart';

class HomeTab extends StatefulWidget {

  static const String routeName = '/HomePage'; // Added Route Name


  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Item? selectedItem; // Holds the currently selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 100,
        elevation: 0,
        title: Text(
          'Market',
          style: TextStyle(
            fontSize: 38,
            color: Colors.white,
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
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
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
            title: 'Hot Deals',
            items: [
              Item(
                imageName: 'assets/images/item1.jpg',
                itemName: 'Cream',
                price: '9.99',
                description: 'Facial cream for dry skin',
              ),
              Item(
                imageName: 'assets/images/item3.jpg',
                itemName: 'Iphone 16',
                price: '499.99',
                description: 'Iphone 16 pro max',
              ),
              Item(
                imageName: 'assets/images/item5.jpg',
                itemName: 'Dress',
                price: '69.99',
                description: 'Red dress for parties',
              ),
              Item(
                imageName: 'assets/images/item2.png',
                itemName: 'Lipstick',
                price: '19.99',
                description: 'Red Lipstick matte',
              ),
              Item(
                imageName: 'assets/images/item4.jpg',
                itemName: 'Laptop',
                price: '699.99',
                description: 'Gaming laptop',
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Trending',
            items: [
              Item(
                imageName: 'assets/images/item6.jpg',
                itemName: 'Racket',
                price: '15.99',
                description: 'Tennis racket for adults',
              ),
              Item(
                imageName: 'assets/images/item10.jpg',
                itemName: 'Iphone 15',
                price: '399.99',
                description: 'Iphone 15 pro max',
              ),
              Item(
                imageName: 'assets/images/item8.jpg',
                itemName: 'TV',
                price: '299.99',
                description: 'TV LCD',
              ),
              Item(
                imageName: 'assets/images/item7.jpg',
                itemName: 'Fridge',
                price: '199.99',
                description: 'Fridge with 10 years warranty',
              ),
              Item(
                imageName: 'assets/images/item9.jpg',
                itemName: 'Eyeshadow',
                price: '49.99',
                description: 'Eyeshadow palette with pink/brown colors',
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'New Release',
            items: [
              Item(
                imageName: 'assets/images/item11.png',
                itemName: 'Dog food',
                price: '12.99',
                description: 'Dry food for adult dogs',
              ),
              Item(
                imageName: 'assets/images/item13.jpg',
                itemName: 'T-Shirt',
                price: '7.99',
                description: 'Basic Red t-shirt for men',
              ),
              Item(
                imageName: 'assets/images/item15.jpg',
                itemName: 'Cap',
                price: '12.99',
                description: 'bb',
              ),
              Item(
                imageName: 'assets/images/item12.jpg',
                itemName: 'Cap',
                price: '12.99',
                description: 'bb',
              ),
              Item(
                imageName: 'assets/images/item14.jpg',
                itemName: 'Cap',
                price: '12.99',
                description: 'bb',
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to Barcode Scanner
          final scannedCode = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BarcodeScannerPage()),
          );

          if (scannedCode != null) {
            // Create the item details based on the scanned barcode
            Item barItem = Item(
              imageName: 'assets/images/image34.jpeg',
              itemName: 'Smart Watch',
              price: '799.99',
              description: 'New Gen Smart Watch',
            );

            // Navigate to the Item Details screen with the scanned item
            Navigator.of(context).pushNamed(
              ItemDetails.routeName,
              arguments: barItem,
            );

            print("Scanned Code: $scannedCode"); // Debugging output
          }
        },

        backgroundColor: Colors.white,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.asset(
              'assets/images/barcode.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Item> items}) {
    return Container(
      color: Colors.white, // ✅ Ensures background is always white
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,  // ✅ Ensures text is always black
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
                  color: Colors.white, // ✅ Ensures Card background is white
                  elevation: 2,
                  margin: EdgeInsets.only(right: 10, bottom: 25),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedItem = item;
                        Navigator.of(context).pushNamed(
                          ItemDetails.routeName,
                          arguments: selectedItem,
                        );
                      });
                    },
                    child: item,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
