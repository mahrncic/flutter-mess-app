import 'package:flutter/material.dart';
import 'package:mess_app/widgets/chats/body.dart';

class ChatsScreen extends StatefulWidget {
  static const pageRoute = '/chats';
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Body(),
    );
  }
}
