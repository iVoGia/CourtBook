import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTheme.label()),
          const SizedBox(height: 2),
          Text(value, style: AppTheme.body(size: 16, weight: FontWeight.w500)),
        ],
      ),
    );
  }
}
