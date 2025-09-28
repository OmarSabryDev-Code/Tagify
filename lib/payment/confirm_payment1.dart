import 'package:flutter/material.dart';
import 'package:tagify/content/home_tab.dart';
import 'package:tagify/profile/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ConfirmPayment1(),
      routes: {
        '/history': (context) => const HistoryPage(), // Define routes
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class ConfirmPayment1 extends StatefulWidget {
  const ConfirmPayment1({super.key});

  static const String routeName = '/confirmpaying';


  @override
  State<ConfirmPayment1> createState() => _ConfirmPayment1State();
}

class _ConfirmPayment1State extends State<ConfirmPayment1> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Your purchase has been successfully completed.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(HomeTab.routeName); // Navigate to HomePage
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Return", style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);// Navigate to HistoryPage
                },
                child: const Text(
                  "History",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400], // Background color
      body: const SizedBox(), // Empty body since dialog appears immediately
    );
  }
}

// Dummy Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: const Center(child: Text("This is the Home Page")),
    );
  }
}

// Dummy History Page
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History Page")),
      body: const Center(child: Text("This is the History Page")),
    );
  }
}
