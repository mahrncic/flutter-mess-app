import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  static Future<DocumentSnapshot> getCurrentUser() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    return Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();
  }

  static Future<String> updateEmailAndPasswordAndGetUid(
      String email, String password) async {
    var currentUser = await FirebaseAuth.instance.currentUser();

    await currentUser.updateEmail(email);
    if (password != null && password.isNotEmpty) {
      await currentUser.updatePassword(password);
    }

    return currentUser.uid;
  }

  static Future<void> updateUser(
      String email, String username, String imageUrl) async {
    var currentUser = await FirebaseAuth.instance.currentUser();

    await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .updateData(
            {'username': username, 'email': email, 'imageUrl': imageUrl});
  }
}
