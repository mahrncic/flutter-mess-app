import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: const EdgeInsets.all(8),
          child: const Text('This works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/Pzomcb9eKEAr2liDejwe/messages')
              .snapshots()
              .listen((data) {
            print(data.documents[0]['text']);
          });
        },
      ),
    );
  }
}
