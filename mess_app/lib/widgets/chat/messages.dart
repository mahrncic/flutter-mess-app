import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final chatDocuments = chatSnapshot.data.documents;

              return ListView.builder(
                reverse: true,
                itemCount: chatDocuments.length,
                itemBuilder: (ctx, i) => MessageBubble(
                  chatDocuments[i]['text'],
                  chatDocuments[i]['username'],
                  chatDocuments[i]['userImage'],
                  chatDocuments[i]['userId'] == futureSnapshot.data.uid,
                  key: ValueKey(chatDocuments[i].documentID),
                ),
              );
            });
      },
    );
  }
}
