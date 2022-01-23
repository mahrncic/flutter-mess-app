import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarInCard extends StatelessWidget {
  final String imageUrl;

  const AvatarInCard(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundImage: CachedNetworkImageProvider(
        imageUrl,
      ),
    );
  }
}
