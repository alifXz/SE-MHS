import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. REGISTER METHOD
  Future<User?> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required int age,
    required String phoneNumber,
  }) async {
    try {
      // 1. Create user in Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      User? user = result.user;

      // 2. Save the extra metadata fields to Firestore matching your ERD
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'userId': user.uid,
          'name': name.trim(),
          'email': email.trim(),
          'age': age,
          'phoneNumber': phoneNumber.trim(),
          'role': 'member', // default fallback role
          'joinedAt': FieldValue.serverTimestamp(),
        });
      }
      return user;
    } catch (e) {
      print("Firebase Registration Error: $e");
      rethrow; // Forward it to the UI to handle and show an error dialog/snackbar
    }
  }


  // 2. LOGIN METHOD
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Login Error: ${e.toString()}");
      rethrow;
    }
  }

  // 3. LOGOUT METHOD
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> getUserName(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();
      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['name'] ?? "User";
      }
      return "User";
    } catch (e) {
      print("Error in getUserName service: $e");
      return "User"; // Fallback name
    }
  }
}

