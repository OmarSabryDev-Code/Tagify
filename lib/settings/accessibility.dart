import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../theme_provider.dart';

class Accessibility extends StatelessWidget {
  static const String routeName = '/accessibility';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 16),
          Container(
            margin: EdgeInsetsDirectional.only(top: 40),
            child: Row(
              children: [
                SizedBox(width: 30),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    CupertinoIcons.xmark,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                SizedBox(width: 50),
                Text(
                  'Accessibility',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8, top: 16),
            child: Column(
              children: [
                SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Image.asset('assets/images/brush2.png'),
                      SizedBox(width: 16),
                      Text(
                        'Theme',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),
                      ),
                      SizedBox(width: 140),

                      Switch(
                        value: themeProvider.themeMode == ThemeMode.dark,
                        onChanged: (value) => themeProvider.toggleTheme(),
                        activeColor: Colors.white,
                        activeTrackColor: AppTheme.primary,
                        inactiveTrackColor: AppTheme.darkGrey,
                        inactiveThumbColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Image.asset('assets/images/globe.png'),
                      SizedBox(width: 25),
                      Text(
                        'Language',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),
                      ),
                      SizedBox(width: 140),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
