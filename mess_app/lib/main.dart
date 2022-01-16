import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/constants/constants.dart';
import 'package:mess_app/enums/auth_status.dart';
import 'package:mess_app/providers/general.dart';
import 'package:mess_app/screens/chat_screen.dart';
import 'package:mess_app/screens/chats_screen.dart';
import 'package:mess_app/screens/login_screen.dart';
import 'package:mess_app/screens/main_navigation_screen.dart';
import 'package:mess_app/screens/search_screen.dart';
import 'package:mess_app/screens/signup_screen.dart';
import 'package:mess_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: General(),
        ),
      ],
      child: Consumer<General>(
        builder: (ctx, general, _) => MaterialApp(
          title: 'Mess App',
          themeMode: general.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData(
            backgroundColor: kPrimaryColor,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: kPrimaryColor,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              surface: kPrimaryColor,
              onSurface: Colors.black,
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              primaryVariant: kPrimaryColor,
              secondary: Colors.grey,
              secondaryVariant: Colors.grey,
              onSecondary: Colors.grey,
              background: Colors.grey,
              onBackground: Colors.grey,
              error: Colors.red,
              onError: Colors.white,
            ),
          ),
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
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              surface: kPrimaryColor,
              onSurface: Colors.black,
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              primaryVariant: kPrimaryColor,
              secondary: Colors.grey,
              secondaryVariant: Colors.grey,
              onSecondary: Colors.grey,
              background: Colors.grey,
              onBackground: Colors.grey,
              error: Colors.red,
              onError: Colors.white,
            ),
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
        ),
      ),
    );
  }
}
