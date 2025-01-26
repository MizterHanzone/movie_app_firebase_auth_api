import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  // Sign-up method
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.trim().isNotEmpty && password.isNotEmpty && name.trim().isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (credential.user != null) {
          // Save user information in Firestore
          try {
            await _firestore.collection('users').doc(credential.user!.uid).set({
              'uid': credential.user!.uid,
              'email': email.trim(),
              'name': name.trim(),
              'createdAt': FieldValue.serverTimestamp(), // Use server timestamp
            });
            res = "success";
          } catch (e) {
            // Log Firestore-specific errors
            res = "Failed to save user data to Firestore: ${e.toString()}";
          }
        } else {
          res = "User creation failed.";
        }
      } else {
        res = "Please fill in all fields.";
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors
      if (e.code == 'email-already-in-use') {
        res = "The email is already in use.";
      } else if (e.code == 'weak-password') {
        res = "The password is too weak.";
      } else {
        res = e.message ?? "An error occurred.";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Login method
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please fill in all fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Logout method
  Future<void> logOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error while logging out: $e");
      rethrow;
    }
  }
}
