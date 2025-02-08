import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../app_theme.dart';

class Linking extends StatelessWidget {
  static const String routeName = '/linking';

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to link Twitter account
  //final TwitterLogin twitterLogin = TwitterLogin(
    //apiKey: 'nEVrMZKH8iwbm2NBCjWmCF9XZ', // Replace with your Twitter API Key
    //apiSecretKey: 'YI2RubHBMkpJlGeiO15ex3bfmcej4vfWNzZnBqYXJZASJIUtMd', redirectURI: 'myapp://twitter-callback'
  //);

  // Function to link Instagram account
  Future<void> _linkInstagram(BuildContext context) async {
    try {
      // Instagram does not have native Firebase support, so you need to use a custom authentication flow.
      // Typically, you'd use an API like Instagram's Graph API.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Instagram linking is not fully implemented in this example.')),
      );
    } catch (e) {
      _showError(context, 'Failed to link Instagram account: $e');
    }
  }

  // Function to link Facebook account
  Future<void> _linkFacebook(BuildContext context) async {
    try {
      // Use Facebook OAuth through Firebase
      // Requires setting up the `flutter_facebook_auth` package.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Facebook linking is not fully implemented in this example.')),
      );
    } catch (e) {
      _showError(context, 'Failed to link Facebook account: $e');
    }
  }

  // Function to link Gmail account
  Future<void> _linkGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return; // User canceled sign-in
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.currentUser?.linkWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully linked Gmail account!')),
      );
    } catch (e) {
      _showError(context, 'Failed to link Gmail account: $e');
    }
  }

  // Function to link Microsoft Outlook account
  Future<void> _linkMicrosoft(BuildContext context) async {
    try {
      // Microsoft does not have direct Firebase support. You would use the OAuth flow with Azure AD.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microsoft Outlook linking is not fully implemented in this example.')),
      );
    } catch (e) {
      _showError(context, 'Failed to link Microsoft Outlook account: $e');
    }
  }

  // Helper function to display error messages
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: const TextStyle(color: Colors.red))),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 30),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(CupertinoIcons.xmark, color: AppTheme.darkGrey, weight: 2),
                ),
                const SizedBox(width: 120),
                Text(
                  'Linking',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 16),
            child: Column(
              children: [
                const SizedBox(height: 32),
                // Twitter Row
                InkWell(
                  onTap: () {},
                  child: _buildRow(context, 'assets/images/twitter.png', 'Twitter'),
                ),
                const SizedBox(height: 32),
                // Instagram Row
                InkWell(
                  onTap: () => _linkInstagram(context),
                  child: _buildRow(context, 'assets/images/instagram.png', 'Instagram'),
                ),
                const SizedBox(height: 32),
                // Facebook Row
                InkWell(
                  onTap: () => _linkFacebook(context),
                  child: _buildRow(context, 'assets/images/facebook.png', 'Facebook'),
                ),
                const SizedBox(height: 32),
                // Gmail Row
                InkWell(
                  onTap: () => _linkGoogle(context),
                  child: _buildRow(context, 'assets/images/gmail.png', 'Gmail'),
                ),
                const SizedBox(height: 32),
                // Microsoft Outlook Row
                InkWell(
                  onTap: () => _linkMicrosoft(context),
                  child: _buildRow(context, 'assets/images/outlook.png', 'Microsoft Outlook'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build each row
  Widget _buildRow(BuildContext context, String iconPath, String platformName) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Image.asset(iconPath),
          const SizedBox(width: 16),
          Text(
            platformName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.primary),
        ],
      ),
    );
  }
}
