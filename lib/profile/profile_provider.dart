import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:tagify/models/profile_model.dart';
import '../auth/user_provider.dart';
import '../firebase_functions.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? _profile;
  bool _isLoading = false;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;

  // Fetch the profile of a user
  Future<void> fetchProfile(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Attempt to fetch the user's profile from Firebase
      _profile = await FirebaseFunctions.getUserProfile(userId);

      // If no profile is found, set the profile to default values
      if (_profile == null) {
        _profile = ProfileModel(
          name: 'userName',
          birthdate: '01-01-2000',
          bio: 'This is a default bio.',
          image: 'assets/images/D.jpg', // Set a default image asset path
        );
        // Add default profile to Firebase if it doesn't exist
        await FirebaseFunctions.addUserProfile(_profile!, userId);
      }
    } catch (e) {
      print("Error fetching profile: $e");

      // In case of error, set the profile to default values
      _profile = ProfileModel(
        name: 'userName',
        birthdate: '01-01-2000',
        bio: 'This is a default bio.',
        image: 'assets/images/D.jpg',
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add a new profile for the user
  Future<void> addProfile(ProfileModel profile, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Add the user's profile to Firebase
      await FirebaseFunctions.addUserProfile(profile, userId);
      _profile = profile;
    } catch (e) {
      print("Error adding profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update an existing profile for the user
  Future<void> updateProfile(ProfileModel updatedProfile, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Check if the profile document exists
      final profileDoc = FirebaseFunctions.getProfileCollection().doc(userId);
      final docSnapshot = await profileDoc.get();

      if (!docSnapshot.exists) {
        // If profile doesn't exist, create it
        await FirebaseFunctions.addUserProfile(updatedProfile, userId);
      } else {
        // If profile exists, update it
        await FirebaseFunctions.updateUserProfile(updatedProfile, userId);
      }

      _profile = updatedProfile;
    } catch (e) {
      print("Error updating profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update profile image specifically
  Future<void> updateProfileImage(String imagePath, String userId) async {
    if (_profile != null) {
      // Update profile image if it exists
      _profile!.image = imagePath;
      notifyListeners();

      // Save the updated profile to Firebase
      await updateProfile(_profile!, userId);
    }
  }

  // Load profile data from Firebase
  Future<void> loadProfile(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final profileData = await FirebaseFunctions.getUserProfile(userId);
      if (profileData != null) {
        _profile = ProfileModel.fromJson(profileData as Map<String, dynamic>);
      } else {
        // If no profile exists, initialize with default values
        _profile = ProfileModel(
          name: 'userName',
          birthdate: '01-01-2000',
          bio: 'This is a default bio.',
          image: 'assets/images/D.jpg',
        );
        await FirebaseFunctions.addUserProfile(_profile!, userId);
      }
    } catch (e) {
      print("Error loading profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}