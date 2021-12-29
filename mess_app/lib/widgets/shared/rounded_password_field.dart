import 'package:flutter/material.dart';
import 'package:mess_app/constants/constants.dart';
import 'package:mess_app/widgets/shared/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueKey<String> textKey;
  const RoundedPasswordField({
    Key key,
    this.textKey,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        key: textKey,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        validator: (value) {
          if (value.isEmpty || value.length < 7) {
            return 'Password must be at least 7 characters long.';
          }
          return null;
        },
        decoration: const InputDecoration(
          hintText: "Password",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryLightColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
