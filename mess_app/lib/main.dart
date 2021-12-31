import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/constants/constants.dart';
import 'package:mess_app/enums/auth_status.dart';
import 'package:mess_app/screens/chat_screen.dart';
import 'package:mess_app/screens/chats_screen.dart';
import 'package:mess_app/screens/login_screen.dart';
import 'package:mess_app/screens/main_navigation_screen.dart';
import 'package:mess_app/screens/search_screen.dart';
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
        return MainNavigationScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess App',
      theme: ThemeData(
        backgroundColor: kPrimaryColor,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: kPrimaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: kMaterialColor,
        ).copyWith(secondary: Colors.orange),
      ),
      home: _getPageBasedOnStatus(),
      routes: {
        ChatScreen.pageRoute: (ctx) => ChatScreen(),
        ChatsScreen.pageRoute: (ctx) => ChatsScreen(),
        LoginScreen.pageRoute: (ctx) => LoginScreen(),
        SignUpScreen.pageRoute: (ctx) => SignUpScreen(),
        SplashScreen.pageRoute: (ctx) => SplashScreen(),
        MainNavigationScreen.pageRoute: (ctx) => MainNavigationScreen(),
        SearchScreen.pageRoute: (ctx) => SearchScreen(),
      },
    );
  }
}
