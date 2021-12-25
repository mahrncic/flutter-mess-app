import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final chatDocuments = chatSnapshot.data.documents;
        return ListView.builder(
            itemCount: chatDocuments.length,
            itemBuilder: (ctx, i) => Text(chatDocuments[i]['text']));
      },
    );
  }
}
