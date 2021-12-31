import 'package:flutter/material.dart';
import 'package:mess_app/screens/chats_screen.dart';
import 'package:mess_app/screens/friends_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const pageRoute = '/main';

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  var _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    ChatsScreen(),
    FriendsScreen(),
    FriendsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Friends",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
