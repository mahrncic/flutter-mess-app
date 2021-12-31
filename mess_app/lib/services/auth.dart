import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static Future signInWithUsernameAndPassword(
      String email, String password) async {
    final _auth = FirebaseAuth.instance;
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await Firestore.instance
        .collection('users')
        .document(authResult.user.uid)
        .setData(
      {
        'username': authResult.user.displayName,
        'email': authResult.user.email,
        'imageUrl': authResult.user.photoUrl
      },
    );
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static Future<AuthResult> signUp(
    String email,
    String password,
    String username,
    File image,
  ) async {
    final _auth = FirebaseAuth.instance;
    var authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(authResult.user.uid + '.jpg');

    await ref.putFile(image).onComplete;

    final imageUrl = await ref.getDownloadURL();

    await Firestore.instance
        .collection('users')
        .document(authResult.user.uid)
        .setData(
      {'username': username, 'email': email, 'imageUrl': imageUrl},
    );

    return authResult;
  }
}
