import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tagify/app_theme.dart';
import 'package:tagify/auth/sign_up.dart';
import 'package:tagify/auth/user_provider.dart';
import 'package:tagify/content/content_screen.dart';
import 'package:tagify/models/user_model.dart';

import '../firebase_functions.dart';
import '../profile/profile_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _isUserSelected = false; // Checkbox for User
  bool _isShopOwnerSelected = false; // Checkbox for Shop Owner
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          SignUp.routeName);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // Email TextField
                    TextField(
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      controller: emailController,
                    ),
                    SizedBox(height: 10),
                    // Password TextField
                    TextField(
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons
                                .visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // User and Shop Owner Checkboxes with responsive layout
              Row(
                children: [
                  Checkbox(
                    value: _isUserSelected,
                    activeColor: AppTheme.primary,
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        _isUserSelected = value ?? false;
                        if (_isUserSelected) {
                          _isShopOwnerSelected = false;
                        }
                      });
                    },
                  ),
                  Text('User', style: TextStyle(fontSize: 15)),
                  SizedBox(width: screenWidth * 0.1),
                  // Responsive width based on screen size
                  Checkbox(
                    value: _isShopOwnerSelected,
                    activeColor: AppTheme.primary,
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        _isShopOwnerSelected = value ?? false;
                        if (_isShopOwnerSelected) {
                          _isUserSelected = false;
                        }
                      });
                    },
                  ),
                  Text('Shop Owner', style: TextStyle(fontSize: 15)),
                ],
              ),
              SizedBox(height: 100),
              // Log In Button
              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Colors.blue[400],
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Google.png',
                      height: 30,
                      width: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        signInWithGoogle(context);
                      },
                      child: Text(
                        'Sign in with google?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Forgot Password TextButton
              Center(
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password logic
                  },
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.login(
        email: emailController.text,
        password: passwordController.text,
        context: context, // Pass the context here
      ).then(
            (user) async {
          // Step 1: Update the UserProvider with the logged-in user
          Provider.of<UserProvider>(context, listen: false).updateUser(user);

          // Step 2: Fetch and load the user's profile data
          final profileProvider = Provider.of<ProfileProvider>(
              context, listen: false);
          await profileProvider.fetchProfile(user.id);

          // Step 3: Navigate to the ContentPage
          Navigator.of(context).pushReplacementNamed(ContentPage.routeName);
        },
      ).catchError(
            (error) {
          String? message;
          if (error is FirebaseAuthException) {
            message = error.message;
          }
          Fluttertoast.showToast(
            msg: message?.isNotEmpty == true
                ? message!
                : 'Something went wrong',
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
          );
        },
      );
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Fluttertoast.showToast(msg: "Google Sign-In Cancelled");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user != null) {
        // Convert Firebase User to UserModel
        UserModel userModel = UserModel.fromFirebaseUser(user);

        // Update the UserProvider
        Provider.of<UserProvider>(context, listen: false).updateUser(userModel);

        // Fetch profile data
        final profileProvider = Provider.of<ProfileProvider>(
            context, listen: false);
        await profileProvider.fetchProfile(user.uid);

        // Navigate to ContentPage
        Navigator.of(context).pushReplacementNamed(ContentPage.routeName);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error signing in: ${error.toString()}");
      print(error);
    }
  }
}
