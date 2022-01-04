import 'package:flutter/material.dart';

class ImageText extends StatelessWidget {
  final String imageAssetPath;
  final String text;

  const ImageText(this.imageAssetPath, this.text);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAssetPath,
            height: size.height * 0.30,
          ),
          SizedBox(height: size.height * 0.05),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
