import 'package:flutter/material.dart';
import 'package:mess_app/screens/search_screen.dart';
import 'package:mess_app/widgets/friends/body.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Friends'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                SearchScreen.pageRoute,
              );
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}
