import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tagify/auth/user_provider.dart';
import 'package:tagify/firebase_functions.dart';
import 'package:tagify/models/profile_model.dart';
import 'package:tagify/profile/profile_provider.dart';

class Personalize extends StatefulWidget {
  static const String routeName = '/personalize';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Personalize> {
  File? _profileImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _bdController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false).profile;
    if (profile != null) {
      _nameController.text = profile.name;
      _bioController.text = profile.bio;
      _bdController.text = profile.birthdate;
      _profileImage = File(profile.image);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _showCustomerSupport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Customer Support'),
          content: Text('How can we help you today?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.isEmpty || _bioController.text.isEmpty || _bdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

    String userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    ProfileModel model = ProfileModel(
      name: _nameController.text,
      bio: _bioController.text,
      birthdate: _bdController.text,
      image: _profileImage?.path ?? 'assets/images/D.jpg', // Default image if none selected
    );

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFunctions.updateUserProfile(model, userId, newImage: _profileImage);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile saved successfully!')));

      Provider.of<ProfileProvider>(context, listen: false).updateProfile(model, userId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save profile: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: _saveProfile,
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.only(top: 35, bottom: 15),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Container(
                        width: 180,
                        height: 190,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : AssetImage('assets/images/D.jpg') as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            size: 24,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                    TextField(controller: _nameController, decoration: InputDecoration(suffixIcon: Icon(Icons.edit, color: Colors.blue))),
                    SizedBox(height: 20),
                    Text("Bio", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                    TextField(controller: _bioController, decoration: InputDecoration(suffixIcon: Icon(Icons.edit, color: Colors.blue))),
                    SizedBox(height: 20),
                    Text("Birth Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                    TextField(controller: _bdController, decoration: InputDecoration(suffixIcon: Icon(Icons.edit, color: Colors.blue))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}