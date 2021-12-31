import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/services/friends.dart';
import 'package:mess_app/widgets/chat/chat_card.dart';
import 'package:mess_app/widgets/friends/friend_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Friends.getFriendsForUser(futureSnapshot.data.uid),
            builder: (ctx, friendsSnapshot) {
              if (friendsSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final friendsDocuments = friendsSnapshot.data.documents;
              if (friendsDocuments.length > 0) {
                return ListView.builder(
                  itemCount: friendsDocuments.length,
                  itemBuilder: (ctx, i) => FriendCard(
                    username: friendsDocuments[i].data['username'],
                    imageUrl: friendsDocuments[i].data['imageUrl'],
                    friendUid: friendsDocuments[i].documentID,
                    currentUserUid: futureSnapshot.data.uid,
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/alone.png",
                        height: size.height * 0.30,
                      ),
                      SizedBox(height: size.height * 0.05),
                      const Text(
                        'You have no friends!',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
            });
      },
    );
  }
}
