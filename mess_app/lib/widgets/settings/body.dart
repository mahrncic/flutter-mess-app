import 'package:flutter/material.dart';
import 'package:mess_app/constants/colors.dart';
import 'package:mess_app/widgets/shared/dark_mode_custom_switch.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
      child: ListView(
        children: [
          Row(
            children: const [
              Icon(
                Icons.volume_up_outlined,
                color: kPrimaryColor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Overall",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          const DarkModeCustomSwitch('Dark Mode'),
          const SizedBox(
            height: 85,
          ),
          Image.asset(
            "assets/images/settings.png",
            height: size.height * 0.25,
          ),
        ],
      ),
    );
  }
}
