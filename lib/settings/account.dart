import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagify/profile/personalize.dart';
import 'package:tagify/settings/linking.dart';

import '../app_theme.dart';

class Account extends StatelessWidget{
  static const String routeName = '/account';

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
                  SizedBox(width: 120,),
                  Text(
                    'Account',
                    style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Column(
                children: [
                  SizedBox(height: 32,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(Personalize.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Image.asset('assets/images/brush.png'),
                          SizedBox(width: 16,),
                          Text('Personalize', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),),
                          SizedBox(width: width * 0.45,),
                          Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.primary,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        //SizedBox(width: ,),
                        Image.asset('assets/images/chain.png'),
                        SizedBox(width: 16,),
                        Text('Linking', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),),
                        SizedBox(width: width * 0.54,),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(Linking.routeName);
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