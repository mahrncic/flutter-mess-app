import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/constants/constants.dart';
import 'package:mess_app/widgets/shared/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueKey<String> textKey;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.textKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        key: textKey,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        enableSuggestions: false,
        validator: (value) {
          if (value.isEmpty || !EmailValidator.validate(value)) {
            return 'Please enter a valid email address.';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryLightColor,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
