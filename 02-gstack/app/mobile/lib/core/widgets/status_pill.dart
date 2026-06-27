import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/format.dart';

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _colors(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        statusLabel(status),
        style: AppTheme.label(color: fg).copyWith(fontSize: 11),
      ),
    );
  }

  (Color, Color) _colors(String s) {
    switch (s) {
      case 'pending':
        return (const Color(0xFFFEF3C7), const Color(0xFFB45309));
      case 'confirmed':
        return (const Color(0xFFDCFCE7), AppTheme.success);
      case 'cancelled':
        return (const Color(0xFFFEE2E2), AppTheme.danger);
      case 'completed':
        return (AppTheme.surfaceMuted, AppTheme.muted);
      default:
        return (AppTheme.surfaceMuted, AppTheme.muted);
    }
  }
}
