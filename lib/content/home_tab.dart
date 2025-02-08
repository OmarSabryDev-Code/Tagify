import 'package:flutter/material.dart';
import 'package:tagify/content/item.dart';
import 'package:tagify/content/item_detaile.dart';
import 'package:tagify/settings/settings_screen.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Item? selectedItem; // Holds the currently selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
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
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
                        Navigator.of(context).pushNamed(ItemDetails.routeName,arguments: selectedItem);
                      });
                    },
                    child: item,
                  ),
                  color: Colors.white,
                  elevation: 0,
                  margin: EdgeInsets.only(right: 10),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
