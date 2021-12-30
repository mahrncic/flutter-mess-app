import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mess_app/screens/login_screen.dart';
import 'package:mess_app/widgets/shared/have_an_account_check.dart';
import 'package:mess_app/widgets/shared/rounded_button.dart';
import 'package:mess_app/widgets/shared/text_input_field.dart';
import 'package:mess_app/widgets/shared/password_input_field.dart';
import 'package:mess_app/widgets/signup/background.dart';
import 'package:mess_app/widgets/signup/social_icon.dart';

import 'or_divider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/signup.png",
              height: size.height * 0.35,
            ),
            TextInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            PasswordInputField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/images/google-plus.png",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
