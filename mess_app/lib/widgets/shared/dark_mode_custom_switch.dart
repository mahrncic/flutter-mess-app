import 'package:flutter/material.dart';
import 'package:mess_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class DarkModeCustomSwitch extends StatefulWidget {
  final String _title;

  const DarkModeCustomSwitch(this._title);

  @override
  _DarkModeCustomSwitchState createState() => _DarkModeCustomSwitchState();
}

class _DarkModeCustomSwitchState extends State<DarkModeCustomSwitch> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
              value: themeProvider.isDarkMode,
              onChanged: (bool val) {
                setState(() {
                  final provider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(val);
                });
              },
            ))
      ],
    );
  }
}
