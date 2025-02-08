import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagify/settings/account.dart';
import 'package:tagify/settings/account_security.dart';

import '../app_theme.dart';

class Accessibility extends StatelessWidget{
  static const String routeName = '/accessibility';

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 30,),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(CupertinoIcons.xmark, color: AppTheme.darkGrey, weight: 2,)),
                  SizedBox(width: 60,),
                  Text(
                    'Accessibility',
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
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Image.asset('assets/images/brush2.png'),
                        SizedBox(width: 16,),
                        Text('Theme', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),),
                        SizedBox(width: width * 0.58,),
                        InkWell(
                            onTap: (){
                            },
                            child: Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.primary,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 32,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Image.asset('assets/images/globe.png'),
                        SizedBox(width: 16,),
                        Text('Language', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),),
                        SizedBox(width: width * 0.55,),
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