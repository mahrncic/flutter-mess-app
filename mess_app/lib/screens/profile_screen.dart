import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/constants/colors.dart';
import 'package:mess_app/screens/settings_screen.dart';
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
    dynamic image,
    BuildContext ctx,
  ) async {
    final currentUserUid =
        await User.updateEmailAndPasswordAndGetUid(email, password);

    if (image is File) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(currentUserUid + '.jpg');
      await ref.putFile(image).onComplete;

      final imageUrl = await ref.getDownloadURL();

      await User.updateUserWithImage(email, username, imageUrl);
    } else {
      await User.updateUser(email, username);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User updated successfully!'),
        backgroundColor: kPrimaryColor,
      ),
    );
  }

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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsScreen()));
            },
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
            userDataSnapshot.data['password'],
            NetworkImage(userDataSnapshot.data['imageUrl']),
          );
        },
      ),
    );
  }
}
