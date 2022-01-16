import 'package:flutter/material.dart';
import 'package:mess_app/providers/general.dart';
import 'package:provider/provider.dart';

class DarkModeCustomSwitch extends StatefulWidget {
  final String _title;

  const DarkModeCustomSwitch(this._title);

  @override
  _DarkModeCustomSwitchState createState() => _DarkModeCustomSwitchState();
}

class _DarkModeCustomSwitchState extends State<DarkModeCustomSwitch> {
  bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<General>(context, listen: false).isDarkMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget._title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: Switch(
              value: isDarkMode,
              onChanged: (bool val) {
                setState(() {
                  isDarkMode = val;
                });
                Provider.of<General>(context, listen: false).setDarkMode(val);
              },
            ))
      ],
    );
  }
}
