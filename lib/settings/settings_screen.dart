import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tagify/settings/accessibility.dart';
import 'package:tagify/settings/account.dart';
import 'package:tagify/settings/account_security.dart';
import 'package:tagify/settings/privacy_security.dart';

import '../app_theme.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifs = false; // Holds notification toggle state

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      notifs = value; // Always update the toggle state first
    });

    if (value) {
      // Request permission
      PermissionStatus status = await Permission.notification.request();

      if (!status.isGranted) {
        setState(() {
          notifs = false; // Revert toggle if permission is denied
        });

        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permission Required"),
        content: const Text("To enable notifications, please allow notification access in your settings."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // ✅ Explicitly set white background
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // ✅ Ensures text stays black
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  _buildSettingItem(
                    context,
                    image: 'assets/images/head.png',
                    title: 'Your Account',
                    onTap: () => Navigator.of(context).pushNamed(Account.routeName),
                  ),
                  const SizedBox(height: 32),
                  _buildSettingItem(
                    context,
                    image: 'assets/images/lock.png',
                    title: 'Account Security',
                    onTap: () => Navigator.of(context).pushNamed(AccountSecurity.routeName),
                  ),
                  const SizedBox(height: 32),
                  _buildSettingItem(
                    context,
                    image: 'assets/images/check.png',
                    title: 'Privacy and Safety',
                    onTap: () => Navigator.of(context).pushNamed(PrivacySecurity.routeName),
                  ),
                  const SizedBox(height: 32),
                  _buildSettingItem(
                    context,
                    image: 'assets/images/person.png',
                    title: 'Accessibility',
                    onTap: () => Navigator.of(context).pushNamed(Accessibility.routeName),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/bell.png', width: 35, height: 35),
                            const SizedBox(width: 16),
                            Text(
                              'Notifications',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.black, // ✅ Ensures text stays black
                              ),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 0.9,
                          child: Switch(
                            activeColor: Colors.white,
                            activeTrackColor: AppTheme.primary,
                            inactiveTrackColor: AppTheme.darkGrey,
                            inactiveThumbColor: Colors.black,
                            value: notifs,
                            onChanged: _toggleNotifications,
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
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, {required String image, required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Image.asset(image, width: 35, height: 35),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.black),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.primary),
          ),
        ],
      ),
    );
  }
}
