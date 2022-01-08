import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mess_app/services/user.dart';
import 'package:mess_app/widgets/profile/body.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _submitSignupForm(
    String email,
    String password,
    String username,
    File image,
    BuildContext ctx,
  ) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: User.getCurrentUser(),
        builder: (ctx, userDataSnapshot) {
          if (userDataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Body(
            _submitSignupForm,
            userDataSnapshot.data['email'],
            userDataSnapshot.data['username'],
            userDataSnapshot.data['email'],
            NetworkImage(userDataSnapshot.data['imageUrl']),
          );
        },
      ),
    );
  }
}
