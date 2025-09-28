import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tagify/models/item_model.dart';
import 'package:tagify/models/user_model.dart';
import 'package:tagify/models/card_model.dart';
import 'package:tagify/models/profile_model.dart';
import 'package:tagify/profile/profile_provider.dart';
import 'package:tagify/auth/user_provider.dart';
import 'package:tagify/models/order_model.dart';
import 'package:intl/intl.dart';

class FirebaseFunctions {
  static CollectionReference<ItemModel> getItemCollection(String userId) =>
      getUserCollection()
          .doc(userId)
          .collection('items')
          .withConverter<ItemModel>(fromFirestore: (docSnapshot, options) =>
          ItemModel.fromJson(docSnapshot.data()!), toFirestore: (itemModel, _) => itemModel.toJson());

  static CollectionReference<UserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
        fromFirestore: (docSnapshot, options) =>
            UserModel.fromJson(docSnapshot.data()!),
        toFirestore: (UserModel, _) => UserModel.toJson(),
      );

  static Future<void> addItemToFirestore(ItemModel item, String userId) {
    CollectionReference<ItemModel> itemCollection = getItemCollection(userId);
    DocumentReference<ItemModel> doc = itemCollection.doc();
    item.id = doc.id;
    return doc.set(item);
  }

  static Future<List<ItemModel>> getAllItemsFromFirestore(String userId) async {
    CollectionReference<ItemModel> taskCollection = getItemCollection(userId);
    QuerySnapshot<ItemModel> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteItemFromFirestore(String taskId, String userId) async {
    CollectionReference<ItemModel> taskCollection = getItemCollection(userId);
    return taskCollection.doc(taskId).delete();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    UserModel user = UserModel(
        id: credential.user!.uid, name: name, email: email);
    CollectionReference<UserModel> userCollection = getUserCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
    required BuildContext context, // Add context to access providers
  }) async {
    // Step 1: Authenticate the user
    UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Step 2: Fetch the user's data from Firestore
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentSnapshot<UserModel> docSnapshot = await userCollection.doc(credential.user!.uid).get();

    if (!docSnapshot.exists) {
      throw Exception("User data not found in Firestore");
    }

    UserModel user = docSnapshot.data()!;

    // Step 3: Fetch the user's profile data from Firestore
    DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
        .collection('profiles') // Replace with your profile collection name
        .doc(credential.user!.uid)
        .get();

    if (profileSnapshot.exists) {
      // Step 4: Update the ProfileProvider with the fetched profile data
      ProfileModel profile = ProfileModel.fromJson(profileSnapshot.data() as Map<String, dynamic>);
      Provider.of<ProfileProvider>(context, listen: false).updateProfile(profile, credential.user!.uid); // Pass userId
    } else {
      // Step 5: If no profile exists, initialize with default values
      Provider.of<ProfileProvider>(context, listen: false).updateProfile(
        ProfileModel(
          name: user.name, // Use the user's name from UserModel
          birthdate: 'Not Available',
          bio: 'No bio available',
          image: 'assets/images/D.jpg', // Default image
        ),
        credential.user!.uid, // Pass userId
      );
    }

    // Step 6: Return the user data
    return user;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<double> calculateTotalPrice(String userId) async {
    List<ItemModel> items = await getAllItemsFromFirestore(userId);
    double totalPrice = items.fold(
      0.0,
          (sum, item) {
        double itemPrice = double.tryParse(item.price ?? '0') ?? 0.0;
        return sum + itemPrice;
      },
    );
    return totalPrice;
  }

  static CollectionReference<CardModel> getCardCollection(String userId) =>
      getUserCollection()
          .doc(userId)
          .collection('cards')
          .withConverter<CardModel>(fromFirestore: (docSnapshot, options) =>
          CardModel.fromJson(docSnapshot.data()!), toFirestore: (CardModel, _) => CardModel.toJson());

  static Future<void> addCardPayment(String userId, CardModel card) async {
    CollectionReference<CardModel> cardCollection = getCardCollection(userId);
    DocumentReference<CardModel> doc = cardCollection.doc();
    card.id = doc.id;
    await doc.set(card);
    await updateUserPaymentStatus(userId, true);
  }

  static Future<void> removeCard(String userId, String cardId) async {
    CollectionReference<CardModel> cardCollection = getCardCollection(userId);
    await cardCollection.doc(cardId).delete();
    QuerySnapshot<CardModel> cardsSnapshot = await cardCollection.get();
    bool hasCards = cardsSnapshot.docs.isNotEmpty;
    await updateUserPaymentStatus(userId, hasCards);
  }

  static Future<void> updateUserPaymentStatus(String userId, bool hasPayment) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    await userCollection.doc(userId).update({'hasPayment': hasPayment});
  }

  static Future<List<CardModel>> getAllCards(String userId) async {
    CollectionReference<CardModel> cardCollection = getCardCollection(userId);
    QuerySnapshot<CardModel> cardsSnapshot = await cardCollection.get();
    return cardsSnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<ProfileModel?> getUserProfile(String userId) async {
    try {
      CollectionReference<ProfileModel> profileCollection = getProfileCollection();
      DocumentSnapshot<ProfileModel> docSnapshot = await profileCollection.doc(userId).get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        return docSnapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
  }

  static Future<void> clearUserItems(String userId) async {
    try {
      CollectionReference<ItemModel> itemCollection = getItemCollection(userId);
      QuerySnapshot<ItemModel> querySnapshot = await itemCollection.get();

      for (QueryDocumentSnapshot<ItemModel> doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print("Error clearing user items: $e");
      rethrow;
    }
  }

  static CollectionReference<ProfileModel> getProfileCollection() =>
      FirebaseFirestore.instance.collection('profiles').withConverter<ProfileModel>(
        fromFirestore: (docSnapshot, options) {
          final data = docSnapshot.data();
          if (data == null) return ProfileModel(name: '', birthdate: '', bio: '', image: '');
          return ProfileModel.fromJson(data);
        },
        toFirestore: (profile, _) => profile.toJson(),
      );

  static Future<void> addUserProfile(ProfileModel profile, String userId) async {
    CollectionReference<ProfileModel> profileCollection = getProfileCollection();
    await profileCollection.doc(userId).set(profile);
  }

  static Future<void> updateUserProfile(ProfileModel updatedProfile, String userId, {File? newImage}) async {
    try {
      CollectionReference<ProfileModel> profileCollection = getProfileCollection();
      DocumentReference<ProfileModel> docRef = profileCollection.doc(userId);
      DocumentSnapshot<ProfileModel> docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        await profileCollection.doc(userId).set(updatedProfile);
      } else {
        await docRef.update(updatedProfile.toJson());
      }
    } catch (e) {
      print("Error updating profile: $e");
      rethrow;
    }
  }

  // New functions added:

  static Future<void> createOrder(
      String userId,
      double totalAmount,
      List<ItemModel> cartItems,
      CardModel selectedCard,
      ) async {
    try {
      final orderRef = FirebaseFirestore.instance.collection('orders').doc();
      await orderRef.set({
        'userId': userId,
        'totalAmount': totalAmount,
        'cartItems': cartItems.map((item) => item.toJson()).toList(),
        'paymentMethod': selectedCard.toJson(),
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error creating order: $e");
      rethrow;
    }
  }

  static Future<List<OrderModel>> getOrdersByUserId(String userId) async {
    try {
      QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      return orderSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Convert Firestore timestamp to DateTime and format it
        DateTime dateTime = (data['timestamp'] as Timestamp).toDate();
        String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime); // MM = month, dd = day, yyyy = year

        return OrderModel(
          id: doc.id,
          date: formattedDate, // Use formatted date
          total: data['totalAmount'].toString(),
          items: (data['cartItems'] as List<dynamic>)
              .map((itemJson) => ItemModel.fromJson(itemJson as Map<String, dynamic>))
              .toList(),
        );
      }).toList();
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }
}