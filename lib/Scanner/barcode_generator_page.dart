import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BarcodeGeneratorPage extends StatelessWidget {
  static const String routeName = '/BarcodeGeneratorPage';
  final String data;

  BarcodeGeneratorPage({required this.data});

  @override
  Widget build(BuildContext context) {
    // Generate a barcode (Code128 format)
    final barcode = Barcode.code128();
    final svg = barcode.toSvg(data, width: 300, height: 100);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          "Generated Barcode",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Generated Barcode for: $data",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SvgPicture.string(svg), // Display the barcode
          ],
        ),
      ),
    );
  }
}
