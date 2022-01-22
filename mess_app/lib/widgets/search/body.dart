import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/widgets/friends/user_card.dart';
import 'package:mess_app/widgets/shared/image_text.dart';

class Body extends StatefulWidget {
  final Stream searchResults;
  final String _currentSearchValue;

  const Body(this.searchResults, this._currentSearchValue);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isFriendAlready(userDocument, currentUserUid) {
    if (userDocument.data['friends'] == null) {
      return false;
    }

    if (userDocument.data['friends']
        .any((y) => y['friendUid'] == currentUserUid)) {
      return true;
    }

    return false;
  }

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
            stream: widget.searchResults,
            builder: (context, usersSnapshot) {
              if (usersSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final usersDocuments = usersSnapshot.data.documents
                  .where((x) =>
                      x.data['username'].toLowerCase().startsWith(
                          widget._currentSearchValue.toLowerCase()) &&
                      widget._currentSearchValue != '' &&
                      x.documentID != futureSnapshot.data.uid)
                  .toList();
              if (widget._currentSearchValue.isEmpty) {
                return const ImageText(
                    "assets/images/search.png", "Start Searching!");
              } else if (usersDocuments.length > 0) {
                return ListView.builder(
                  itemCount: usersDocuments.length,
                  itemBuilder: (ctx, i) => UserCard(
                    username: usersDocuments[i].data['username'],
                    imageUrl: usersDocuments[i].data['imageUrl'],
                    friendUid: usersDocuments[i].documentID,
                    currentUserUid: futureSnapshot.data.uid,
                    isFriendAlready: _isFriendAlready(
                        usersDocuments[i], futureSnapshot.data.uid),
                  ),
                );
              } else {
                return const ImageText(
                    "assets/images/not-found.png", "No Users Found!");
              }
            });
      },
    );
  }
}
