import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mess_app/constants/colors.dart';
import 'package:mess_app/screens/chats_screen.dart';
import 'package:mess_app/screens/login_screen.dart';
import 'package:mess_app/screens/main_navigation_screen.dart';
import 'package:mess_app/services/auth.dart';
import 'package:mess_app/widgets/signup/body.dart';

class SignUpScreen extends StatefulWidget {
  static const pageRoute = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _isLoading = false;

  Future<void> _signInWithGoogle() async {
    try {
      await Auth.signInWithGoogle();
      Navigator.of(context).pushReplacementNamed(
        MainNavigationScreen.pageRoute,
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
    try {
      setState(() {
        _isLoading = true;
      });

      await Auth.signUp(email, password, username, image);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added successfully!'),
          backgroundColor: kPrimaryColor,
        ),
      );
      Navigator.of(context).pushReplacementNamed(
        LoginScreen.pageRoute,
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
