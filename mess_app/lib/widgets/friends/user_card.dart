import 'package:flutter/material.dart';
import 'package:mess_app/services/friends.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    @required this.username,
    @required this.imageUrl,
    @required this.friendUid,
    @required this.currentUserUid,
    @required this.isFriendAlready,
  });

  final String username;
  final String imageUrl;
  final String friendUid;
  final String currentUserUid;
  final bool isFriendAlready;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20 * 0.75),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: widget.isFriendAlready ? null : () {},
              child: const Text('Add Friend'),
            ),
          ],
        ),
      ),
    );
  }
}
