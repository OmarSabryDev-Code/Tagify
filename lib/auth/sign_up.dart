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

class SignUp extends StatefulWidget{
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
  bool _isUserSelected = false; // Checkbox for User
  bool _isShopOwnerSelected = false;
  bool readTerms = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 16,),
          Container(
            margin: EdgeInsetsDirectional.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.xmark, color: AppTheme.darkGrey, weight: 2,),
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.titleMedium,),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text('Login',
                  style: Theme.of(context).textTheme.titleSmall,),
                ),
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Column(
                children: [
                  SizedBox(height: 24,),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: AppTheme.grey,
                      border: Border.all(color: AppTheme.lightGrey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DefaultTextFormField(
                      hintText: 'Name',
                      controller: nameController,
                      validator: (value){
                        if(value == null || value.trim().length<3){
                          return'Name must be more than 2 characters';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: AppTheme.grey,
                      border: Border.all(color: AppTheme.lightGrey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DefaultTextFormField(
                      hintText: 'Email',
                      controller: emailController,
                      validator: (value){
                        if(value == null || value.trim().length<3){
                          return'Name must be more than 2 characters';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: AppTheme.grey,
                      border: Border.all(color: AppTheme.lightGrey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DefaultTextFormField(
                      isPassword: true,
                      hintText: 'Password',
                      controller: passwordController,
                      validator: (value){
                        if(value == null || value.trim().length<3){
                          return'Name must be more than 2 characters';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: AppTheme.grey,
                      border: Border.all(color: AppTheme.lightGrey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DefaultTextFormField(
                      hintText: 'Phone',
                      controller: phoneController,
                      validator: (value){
                        if(value == null || value.trim().length<3){
                          return'Name must be more than 2 characters';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: AppTheme.grey,
                      border: Border.all(color: AppTheme.lightGrey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DefaultTextFormField(
                      hintText: 'Address',
                      controller: addressController,
                      validator: (value){
                        if(value == null || value.trim().length<3){
                          return'Name must be more than 2 characters';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
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
                        SizedBox(width: width * 0.1), // Responsive width based on screen size
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
                  ),
                  SizedBox(height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/images/visa.png'),
                      Image.asset('assets/images/insta.png'),
                      Image.asset('assets/images/vodaphone.png'),
                    ],
                  ),
                  //SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Checkbox(
                          value: readTerms,
                          activeColor: AppTheme.primary,
                          checkColor: Colors.white,
                          onChanged: (bool? value) {
                            setState(() {
                              readTerms = value ?? false;
                              }
                            );
                          },
                        ),
                        Text('I have read the terms and conditions', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                  //SizedBox(height: 16,),
                  SizedBox(
                    width: width * 0.7,
                    height: height * 0.05,
                    child: ElevatedButton(
                        onPressed: (){
                          Register();
                        },
                        child: Text('Sign Up', style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppTheme.white, fontWeight: FontWeight.w600),)
                    ),
                  ),
                  //SizedBox(height: 16,),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                  }, child: Text('Already have an account? Login'),),
                ],
            ),
          ),
        ],
      ),
    );
  }
  void Register(){
    if(formKey.currentState!.validate()){
      FirebaseFunctions.register(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text
      ).then(
            (user){
          Provider.of<UserProvider>(context, listen: false).updateUser(user);
          Navigator.of(context).pushReplacementNamed(ContentPage.routeName);
        },
      ).catchError(
            (error) {
          String? message;
          if(error is FirebaseAuthException){
            message = error.message;
          }
          Fluttertoast.showToast(
            msg: message ?? 'Something went wrong',
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
          );
        },
      );
    }
  }
}