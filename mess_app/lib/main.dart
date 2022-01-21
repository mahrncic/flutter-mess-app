import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/constants/themes.dart';
import 'package:mess_app/enums/auth_status.dart';
import 'package:mess_app/providers/theme_provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Mess App',
          themeMode: themeProvider.themeMode,
          darkTheme: Themes.darkTheme,
          theme: Themes.lightTheme,
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
      },
    );
  }
}
