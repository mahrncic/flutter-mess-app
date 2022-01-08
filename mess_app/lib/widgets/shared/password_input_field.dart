import 'package:flutter/material.dart';
import 'package:mess_app/constants/constants.dart';
import 'package:mess_app/widgets/shared/text_field_container.dart';

class PasswordInputField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final ValueKey<String> textKey;
  final String initialValue;
  final bool ignoreValidation;

  const PasswordInputField({
    Key key,
    this.textKey,
    this.onChanged,
    this.initialValue,
    this.ignoreValidation = false,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  var _isPasswordObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscure = !_isPasswordObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        key: widget.textKey,
        obscureText: _isPasswordObscure,
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        cursorColor: kPrimaryColor,
        validator: (value) {
          if (widget.ignoreValidation) {
            return null;
          }
          if (value.isEmpty || value.length < 7) {
            return 'Password must be at least 7 characters long.';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Password",
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
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordObscure ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
      ),
    );
  }
}
