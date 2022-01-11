import 'package:flutter/material.dart';
import 'package:mess_app/screens/signup_screen.dart';
import 'package:mess_app/validations/form_validations.dart';
import 'package:mess_app/widgets/login/bakcground.dart';
import 'package:mess_app/widgets/shared/have_an_account_check.dart';
import 'package:mess_app/widgets/shared/rounded_button.dart';
import 'package:mess_app/widgets/shared/text_input_field.dart';
import 'package:mess_app/widgets/shared/password_input_field.dart';

class Body extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    BuildContext ctx,
  ) submitFn;

  Body(
    this.submitFn,
    this.isLoading,
  );

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
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
              Image.asset(
                "assets/images/login.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              TextInputField(
                hintText: "Your Email",
                textKey: const ValueKey('email'),
                onChanged: (value) {
                  _userEmail = value;
                },
              ),
              PasswordInputField(
                textKey: const ValueKey('password'),
                ignoreValidation: true,
                onChanged: (value) {
                  _userPassword = value;
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: _trySubmit,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.of(context).pushReplacementNamed(
                    SignUpScreen.pageRoute,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
