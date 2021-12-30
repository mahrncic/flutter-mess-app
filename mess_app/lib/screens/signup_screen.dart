import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mess_app/constants/constants.dart';
import 'package:mess_app/screens/login_screen.dart';
import 'package:mess_app/widgets/signup/body.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  Future<void> _signInWithGoogle() async {
    AuthResult authResult;
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    try {
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
    } catch (error) {
      print(error);
    }
  }

  Future<void> _submitSignupForm(
    String email,
    String password,
    String username,
    File image,
    BuildContext ctx,
  ) async {
    AuthResult authResult;

    try {
      setState(() {
        _isLoading = true;
      });

      authResult = await _auth.createUserWithEmailAndPassword(
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added successfully!'),
          backgroundColor: kPrimaryColor,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    } on PlatformException catch (error) {
      var message = 'An error occurred, please check your credentials!';

      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(_submitSignupForm, _isLoading, _signInWithGoogle),
    );
  }
}
