import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mess_app/screens/login_screen.dart';
import 'package:mess_app/validations/form_validations.dart';
import 'package:mess_app/widgets/pickers/user_image_picker.dart';
import 'package:mess_app/widgets/shared/have_an_account_check.dart';
import 'package:mess_app/widgets/shared/rounded_button.dart';
import 'package:mess_app/widgets/shared/text_input_field.dart';
import 'package:mess_app/widgets/shared/password_input_field.dart';
import 'package:mess_app/widgets/signup/background.dart';
import 'package:mess_app/widgets/signup/social_icon.dart';

import 'or_divider.dart';

class Body extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File image,
    BuildContext ctx,
  ) submitFn;

  final void Function() googleSignIn;

  Body(
    this.submitFn,
    this.isLoading,
    this.googleSignIn,
  );

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _username = '';
  var _userPassword = '';
  File _userImageFile;

  void _handlePickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _username.trim(),
        _userImageFile,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UserImagePicker(_handlePickedImage),
              TextInputField(
                hintText: "Your Email",
                textKey: const ValueKey('email'),
                onChanged: (value) {
                  _userEmail = value;
                },
                validationFn: validateEmail,
              ),
              TextInputField(
                hintText: "Username",
                textKey: const ValueKey('username'),
                icon: Icons.person,
                onChanged: (value) {
                  _username = value;
                },
                validationFn: validateUsername,
              ),
              PasswordInputField(
                textKey: const ValueKey('password'),
                onChanged: (value) {
                  _userPassword = value;
                },
              ),
              RoundedButton(
                text: "SIGNUP",
                press: _trySubmit,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.of(context).pushReplacementNamed(
                    LoginScreen.pageRoute,
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSrc: "assets/images/google.png",
                    press: widget.googleSignIn,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
