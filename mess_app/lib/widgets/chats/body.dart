import 'package:flutter/material.dart';
import 'package:mess_app/Chat.dart';
import 'package:mess_app/constants/colors.dart';
import 'package:mess_app/widgets/chat/chat_card.dart';
import 'package:mess_app/widgets/shared/filled_outline_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Messages"),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () {},
            ),
          ),
        ),
      ],
    );
  }
}
