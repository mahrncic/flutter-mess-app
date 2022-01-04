import 'package:flutter/material.dart';
import 'package:mess_app/services/friends.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    @required this.username,
    @required this.imageUrl,
    @required this.friendUid,
  });

  final String username;
  final String imageUrl;
  final String friendUid;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red.shade900,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.delete,
                size: 35,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      key: Key(username),
      onDismissed: (_) async {
        await Friends.deleteFriend(friendUid);
      },
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete Confirmation"),
              content:
                  const Text("Are you sure you want to delete this friend?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Delete")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
      direction: DismissDirection.startToEnd,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20 * 0.75),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
