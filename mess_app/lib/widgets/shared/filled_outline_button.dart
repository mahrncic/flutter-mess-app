import 'package:flutter/material.dart';
import 'package:mess_app/constants/colors.dart';

class FillOutlineButton extends StatelessWidget {
  const FillOutlineButton({
    this.isFilled = true,
    @required this.press,
    @required this.text,
  });

  final bool isFilled;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 150,
      height: 45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.white),
      ),
      elevation: isFilled ? 2 : 0,
      color: isFilled ? Colors.white : Colors.transparent,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? kPrimaryColor : Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
