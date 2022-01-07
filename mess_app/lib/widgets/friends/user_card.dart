import 'package:flutter/material.dart';
import 'package:mess_app/services/friends.dart';
import 'package:mess_app/widgets/shared/avatar_in_card.dart';
import 'package:mess_app/widgets/shared/label_in_card.dart';

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
            AvatarInCard(widget.imageUrl),
            LabelInCard(widget.username),
            TextButton(
              onPressed: widget.isFriendAlready
                  ? null
                  : () async {
                      await Friends.addFriend(
                        widget.friendUid,
                        widget.username,
                        widget.imageUrl,
                      );
                    },
              child: widget.isFriendAlready
                  ? const Text('Connected')
                  : const Text(
                      'Add Friend',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
