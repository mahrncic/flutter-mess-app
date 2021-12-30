import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/enums/auth_status.dart';
import 'package:mess_app/screens/chat_screen.dart';
import 'package:mess_app/screens/login_screen.dart';
import 'package:mess_app/screens/signup_screen.dart';
import 'package:mess_app/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var authStatus = AuthStatus.waiting;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FirebaseAuth.instance.currentUser().then((FirebaseUser currentUser) {
      setState(() {
        authStatus = currentUser == null
            ? AuthStatus.notAuthenticated
            : AuthStatus.authenticated;
      });
    });
  }

  Widget _getPageBasedOnStatus() {
    switch (authStatus) {
      case AuthStatus.waiting:
        return SplashScreen();
      case AuthStatus.notAuthenticated:
        return LoginScreen();
      case AuthStatus.authenticated:
        return ChatScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess App',
      theme: ThemeData(
        backgroundColor: Colors.blue,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.orange),
      ),
      home: _getPageBasedOnStatus(),
    );
  }
}
