import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mess_app/screens/chats_screen.dart';
import 'package:mess_app/screens/main_navigation_screen.dart';
import 'package:mess_app/services/auth.dart';
import 'package:mess_app/widgets/login/body.dart';

class LoginScreen extends StatefulWidget {
  static const pageRoute = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;

  Future<void> _submitLoginForm(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });

      await Auth.signInWithUsernameAndPassword(email, password);
      Navigator.of(context).pushReplacementNamed(
        MainNavigationScreen.pageRoute,
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        _submitLoginForm,
        _isLoading,
      ),
    );
  }
}
