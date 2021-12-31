import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const pageRoute = '/splash';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
