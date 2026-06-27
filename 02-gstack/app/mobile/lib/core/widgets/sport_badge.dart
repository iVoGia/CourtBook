import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/format.dart';

class SportBadge extends StatelessWidget {
  const SportBadge({super.key, required this.sport});

  final String sport;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = AppTheme.sportColors(sport);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        sportLabel(sport),
        style: AppTheme.label(color: fg).copyWith(fontSize: 11),
      ),
    );
  }
}
