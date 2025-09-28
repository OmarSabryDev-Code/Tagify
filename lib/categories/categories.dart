import 'package:flutter/material.dart';
import 'package:tagify/Scanner/barcode_scanner_page.dart';
import 'package:tagify/categories/Arts.dart';
import 'package:tagify/categories/Beauty.dart';
import 'package:tagify/categories/Electronics.dart';
import 'package:tagify/categories/Fashion.dart';
import 'package:tagify/categories/Pets.dart';
import 'package:tagify/categories/Sports.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of image paths and category names
    final List<Map<String, String>> categories = [
      {'image': 'assets/images/beauty.jpg', 'name': 'Beauty'},
      {'image': 'assets/images/fashion.jpg', 'name': 'Fashion'},
      {'image': 'assets/images/elect.jpg', 'name': 'Electronics'},
      {'image': 'assets/images/sport.jpg', 'name': 'Sports'},
      {'image': 'assets/images/Arts&Crafts.jpg', 'name': 'Arts'},
      {'image': 'assets/images/pet.png', 'name': 'Pets'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Categories',
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

              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
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
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                crossAxisSpacing: 10, // Horizontal spacing
                mainAxisSpacing: 10, // Vertical spacing
                childAspectRatio: 1, // Adjust the aspect ratio as needed
              ),
              padding: EdgeInsets.all(10),
              itemCount: categories.length, // Number of categories
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    final routes = {
                      'Beauty': Beauty.routeName,
                      'Fashion': Fashion.routeName,
                      'Electronics': Electronics.routeName,
                      'Sports': Sports.routeName,
                      'Pets': Pets.routeName,
                      'Arts': Arts.routeName,
                    };

                    final routeName = routes[categories[index]['name']];
                    if (routeName != null) {
                      Navigator.of(context).pushNamed(routeName);
                    } else {
                      print('Tapped on ${categories[index]['name']}');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            categories[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            categories[index]['name']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final scannedCode = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BarcodeScannerPage()),
          );
          if (scannedCode != null) {
            print("Scanned Code: $scannedCode"); // Handle the scanned code here
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
}
