import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final File? image;
  const ImageWidget({Key? key, this.imageUrl, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      if (imageUrl == null) {
        return Image.asset(
          'assets/profile_default.png',
          fit: BoxFit.cover,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Container(
                      margin: const EdgeInsets.all(20),
                      child: const CircularProgressIndicator())),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
    } else {
      return Image.file(
        image!,
        fit: BoxFit.cover,
      );
    }
  }
}
