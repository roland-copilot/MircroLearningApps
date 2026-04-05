import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String fullName, String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Store user details in Firestore
      if (credential.user != null) {
        await firestore.collection('users').doc(credential.user!.uid).set({
          'fullName': fullName,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'streak': 0, // Mock stats init
          'documentsUploaded': 0,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
