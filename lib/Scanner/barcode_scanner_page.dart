import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class BarcodeScannerPage extends StatefulWidget {
  static const String routeName = '/BarcodeScannerPage';
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  MobileScannerController controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera permission is required")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black, // Change AppBar color
          title: Text(
            "Scan Barcode",
            style: TextStyle(
              fontSize: 25, // Custom font size
              fontWeight: FontWeight.bold, // Bold text
              color: Colors.white, // Text color
              fontFamily: 'Roboto', // Use custom font if added
            ),
          ),
          centerTitle: true, // Center align the text
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Custom back button
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            String scannedCode = barcodes.first.rawValue ?? "Unknown";
            Navigator.pop(context, scannedCode);
          }
        },
      ),
    );
  }
}
