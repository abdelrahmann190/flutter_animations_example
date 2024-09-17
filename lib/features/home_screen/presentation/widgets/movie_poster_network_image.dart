import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MoviePosterNetworkImage extends StatelessWidget {
  final String? posterPath;
  const MoviePosterNetworkImage({
    super.key,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/w500$posterPath',
      placeholder: (context, url) => Shimmer(
        color: Colors.white,
        colorOpacity: 0,
        enabled: true,
        direction: const ShimmerDirection.fromLTRB(),
        child: Container(
          color: Colors.grey,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      errorListener: (value) {},
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      fit: BoxFit.cover,
    );
  }
}
