import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagify/settings/account.dart';

import '../app_theme.dart';

class AccountSecurity extends StatelessWidget{
  static const String routeName = '/account_security';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsetsDirectional.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 30,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                      child: Icon(CupertinoIcons.xmark, color: AppTheme.darkGrey, weight: 2,)),
                  SizedBox(width: 20,),
                  Text(
                    'Account Security',
                    style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Column(
                children: [
                  SizedBox(height: 32,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Image.asset('assets/images/factor.png'),
                        SizedBox(width: 15,),
                        Text('Two Factor Authentication', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),),
                        SizedBox(width: width * 0.07,),
                        InkWell(
                            onTap: (){
                            },
                            child: Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.primary,)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

}