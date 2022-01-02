import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/services/friends.dart';
import 'package:mess_app/widgets/friends/user_card.dart';

class SearchScreen extends StatefulWidget {
  static const pageRoute = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Stream searchResults = Friends.searchByUsername('');
  final _textController = TextEditingController();
  var _currentSearchValue = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // The search area here
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _textController,
              onChanged: (val) {
                setState(() {
                  _currentSearchValue = val;
                  searchResults = Friends.searchByUsername(val);
                });
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _textController.clear();
                        searchResults = Friends.searchByUsername('');
                      });
                    },
                  ),
                  hintText: 'Exact username...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: searchResults,
              builder: (context, usersSnapshot) {
                if (usersSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final usersDocuments = usersSnapshot.data.documents
                    .where((x) =>
                        x.data['username']
                            .toLowerCase()
                            .startsWith(_currentSearchValue.toLowerCase()) &&
                        _currentSearchValue != '')
                    .toList();
                if (usersDocuments.length > 0) {
                  return ListView.builder(
                    itemCount: usersDocuments.length,
                    itemBuilder: (ctx, i) => UserCard(
                      username: usersDocuments[i].data['username'],
                      imageUrl: usersDocuments[i].data['imageUrl'],
                      friendUid: usersDocuments[i].documentID,
                      currentUserUid: futureSnapshot.data.uid,
                      isFriendAlready: !(usersDocuments[i].data['friends'] !=
                              null) ||
                          usersDocuments[i].data['friends'].any(
                              (y) => y['friendUid'] == futureSnapshot.data.uid),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/not-found.png",
                          height: size.height * 0.30,
                        ),
                        SizedBox(height: size.height * 0.05),
                        const Text(
                          'No Users Found!',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
