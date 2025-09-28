import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tagify/app_theme.dart';
import 'package:tagify/auth/log_in.dart';
import 'package:tagify/auth/user_provider.dart';
import 'package:tagify/content/content_screen.dart';

import '../firebase_functions.dart';
import '../widgets/default_text_form_field.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool _isUserSelected = false;
  bool _isShopOwnerSelected = false;
  bool readTerms = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildHeader(),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(border: Border.all(width:1 ,color: Color(0xffeeeeee)), borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
                        child: buildInputField(nameController, 'Name', (value) {
                          if (value == null || value.trim().length < 3) {
                            return 'Name must be more than 2 characters';
                          }
                          return null;
                        }),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(border: Border.all(width:1 ,color: Color(0xffeeeeee)), borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
                        child: buildInputField(emailController, 'Email', (value) {
                          if (value == null || value.isEmpty) return 'Email cannot be empty';
                          return null;
                        }),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(border: Border.all(width:1 ,color: Color(0xffeeeeee)), borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
                        child: buildInputField(passwordController, 'Password', (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        }, isPassword: true),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(border: Border.all(width:1 ,color: Color(0xffeeeeee)), borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
                        child: buildInputField(phoneController, 'Phone', (value) {
                          if (value == null || value.isEmpty) return 'Phone cannot be empty';
                          if (!RegExp(r'^\d{11}$').hasMatch(value)){
                            return 'Phone number must be exactly 11 digits';
                          }
                          return null;
                        }),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(border: Border.all(width:1 ,color: Color(0xffeeeeee)), borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
                        child: buildInputField(addressController, 'Address', (value) {
                          if (value == null || value.trim().length < 3) {
                            return 'Address must be more than 2 characters';
                          }
                          return null;
                        }),
                      ),
                      buildCheckboxRow(),
                      SizedBox(height: 24),
                      buildPaymentIcons(),
                      buildTermsCheckbox(),
                      SizedBox(height: 16),
                      buildSignUpButton(),
                      buildLoginLink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(CupertinoIcons.xmark, color: AppTheme.darkGrey),
            onPressed: () => Navigator.pop(context),
          ),
          Text('Sign Up', style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
            child: Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String hintText, String? Function(String?) validator, {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: DefaultTextFormField(
        hintText: hintText,
        controller: controller,
        validator: validator,
        isPassword: isPassword,
      ),
    );
  }


  Widget buildCheckboxRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: _isUserSelected,
          activeColor: AppTheme.primary,
          onChanged: (bool? value) {
            setState(() {
              _isUserSelected = value ?? false;
              if (_isUserSelected) _isShopOwnerSelected = false;
            });
          },
        ),
        Text('User'),
        SizedBox(width: 100),
        Checkbox(
          value: _isShopOwnerSelected,
          activeColor: AppTheme.primary,
          onChanged: (bool? value) {
            setState(() {
              _isShopOwnerSelected = value ?? false;
              if (_isShopOwnerSelected) _isUserSelected = false;
            });
          },
        ),
        Text('Shop Owner'),
      ],
    );
  }

  Widget buildPaymentIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset('assets/images/visa.png', height: 60),
        Image.asset('assets/images/insta.png', height: 60),
        Image.asset('assets/images/vodaphone.png', height: 60),
      ],
    );
  }

  Widget buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: readTerms,
          activeColor: AppTheme.primary,
          onChanged: (bool? value) {
            setState(() => readTerms = value ?? false);
          },
        ),
        Text('I have read the terms and conditions'),
      ],
    );
  }

  Widget buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : Register,
        child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Sign Up', style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildLoginLink() {
    return TextButton(
      onPressed: () => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
      child: Text('Already have an account? Login', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    );
  }

  void Register() {
    if (!formKey.currentState!.validate() || (!_isUserSelected && !_isShopOwnerSelected) || !readTerms) return;
    setState(() => _isLoading = true);
    FirebaseFunctions.register(name: nameController.text, email: emailController.text, password: passwordController.text)
        .then((user) {
      Provider.of<UserProvider>(context, listen: false).updateUser(user);
      Navigator.of(context).pushReplacementNamed(ContentPage.routeName);
    })
        .catchError((error) => Fluttertoast.showToast(msg: error.message ?? 'Something went wrong', backgroundColor: Colors.red))
        .whenComplete(() => setState(() => _isLoading = false));
  }
}
