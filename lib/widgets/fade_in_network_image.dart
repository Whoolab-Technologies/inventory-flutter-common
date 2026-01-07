import 'package:flutter/material.dart';

class FadeInNetworkImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;

  const FadeInNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  @override
  State<FadeInNetworkImage> createState() => _FadeInNetworkImageState();
}

class _FadeInNetworkImageState extends State<FadeInNetworkImage> {
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            opacity: _isLoaded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: Image.network(
              widget.imageUrl,
              fit: widget.fit,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  // ✅ fully loaded
                  if (!_isLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() => _isLoaded = true);
                    });
                  }
                  return child;
                }
                return const SizedBox.shrink(); // hide until loaded
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 50);
              },
            ),
          ),
          if (!_isLoaded)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
