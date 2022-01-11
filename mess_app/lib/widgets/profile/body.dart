import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mess_app/validations/form_validations.dart';
import 'package:mess_app/widgets/pickers/user_image_picker.dart';
import 'package:mess_app/widgets/shared/password_input_field.dart';
import 'package:mess_app/widgets/shared/rounded_button.dart';
import 'package:mess_app/widgets/shared/text_input_field.dart';
import 'package:mess_app/widgets/signup/background.dart';

class Body extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    dynamic image,
    BuildContext ctx,
  ) submitFn;
  var userEmail;
  var username;
  var userPassword;
  var userImageFile;

  Body(
    this.submitFn,
    this.userEmail,
    this.username,
    this.userPassword,
    this.userImageFile,
  );

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  void _handlePickedImage(File image) {
    widget.userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (widget.userImageFile == null) {
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
        widget.userEmail,
        widget.userPassword,
        widget.username,
        widget.userImageFile,
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
              UserImagePicker(
                _handlePickedImage,
                'Update Image',
                initialFile: widget.userImageFile,
              ),
              TextInputField(
                hintText: "Your Email",
                initialValue: widget.userEmail,
                textKey: const ValueKey('email'),
                onChanged: (value) {
                  widget.userEmail = value;
                },
                validationFn: validateEmail,
              ),
              TextInputField(
                hintText: "Username",
                initialValue: widget.username,
                textKey: const ValueKey('username'),
                icon: Icons.person,
                onChanged: (value) {
                  widget.username = value;
                },
                validationFn: validateUsername,
              ),
              PasswordInputField(
                textKey: const ValueKey('password'),
                ignoreValidation: true,
                onChanged: (value) {
                  widget.userPassword = value;
                },
              ),
              RoundedButton(
                text: "SAVE",
                press: _trySubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
