import 'package:flutter/material.dart';
import 'package:mess_app/services/friends.dart';
import 'package:mess_app/widgets/search/body.dart';

class SearchScreen extends StatefulWidget {
  static const pageRoute = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Stream searchResults = Friends.searchByUsername('');
  var _currentSearchValue = '';
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  hintText: 'Username starts with...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Body(searchResults, _currentSearchValue),
    );
  }
}
