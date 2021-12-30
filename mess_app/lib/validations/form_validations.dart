import 'package:email_validator/email_validator.dart';

String validateEmail(email) {
  if (email.isEmpty || !EmailValidator.validate(email)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

String validateUsername(username) {
  if (username.isEmpty || username.length < 4) {
    return 'Please enter at least 4 characters';
  }
  return null;
}
