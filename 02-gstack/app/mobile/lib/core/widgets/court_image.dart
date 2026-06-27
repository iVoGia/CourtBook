import 'package:flutter/material.dart';

import '../utils/court_images.dart';

class CourtImage extends StatelessWidget {
  const CourtImage({
    super.key,
    required this.court,
    this.aspectRatio = 16 / 9,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.expand = false,
  });

  final Map<String, dynamic> court;
  final double aspectRatio;
  final double borderRadius;
  final BoxFit fit;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final sport = court['sport_type']?.toString();
    final asset = CourtImages.assetForSport(sport);

    Widget image = Image.asset(
      asset,
      fit: fit,
      width: expand ? double.infinity : null,
      height: expand ? double.infinity : null,
      errorBuilder: (_, __, ___) => Image.asset(
        CourtImages.placeholder,
        fit: fit,
        width: expand ? double.infinity : null,
        height: expand ? double.infinity : null,
      ),
    );

    if (expand) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(aspectRatio: aspectRatio, child: image),
    );
  }
}
