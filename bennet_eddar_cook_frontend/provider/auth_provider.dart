import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if a user exists based on their phone number in Firestore
  static Future<bool> checkUserExistence(String phoneNumber) async {
    try {
      String phone ='+213$phoneNumber';
      // Query Firestore to check if a user with the given phone number exists
      QuerySnapshot querySnapshot = await _firestore
          .collection('users') 
          .where('phoneNumber', isEqualTo: phone)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      // Handle errors, e.g., print(error);
      return false;
    }
  }

  // Add a new user to Firestore
  static Future<void> addUserToFirestore(String phoneNumber) async {
    try {
      // Add a new user document to the Firestore collection
      await _firestore.collection('users').add({
        'phoneNumber': phoneNumber,
        // Add other user details as needed
      });
    } catch (error) {
      // Handle errors, e.g., print(error);
    }
  }
}
