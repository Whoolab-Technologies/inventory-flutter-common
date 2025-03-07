import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImageWidget extends StatelessWidget {
  const AppCachedImageWidget({
    super.key,
    required this.imageUrl,
    required this.imageProvider,
  });
  final String imageUrl;
  final ImageProvider imageProvider;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) =>
          _buildImageContainer(imageProvider),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => _buildImageContainer(imageProvider),
    );
  }

  Container _buildImageContainer(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
