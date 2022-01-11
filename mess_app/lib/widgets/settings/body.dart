import 'package:flutter/material.dart';
import 'package:mess_app/constants/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          buildNotificationOptionRow("Dark Mode", false),
          buildNotificationOptionRow("Fingerprint Lock Screen", false),
          buildNotificationOptionRow("Notifications", false),
        ],
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    bool _isActive = isActive;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: Switch(
              value: _isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }
}
