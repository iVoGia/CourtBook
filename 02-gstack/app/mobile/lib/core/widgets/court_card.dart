import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/format.dart';
import 'court_image.dart';
import 'sport_badge.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({
    super.key,
    required this.court,
    required this.onBook,
  });

  final Map<String, dynamic> court;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final sport = court['sport_type']?.toString() ?? '';
    final capacity = court['capacity'] as int? ?? 0;
    final price = court['hourly_price'] as num? ?? 0;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              CourtImage(court: court),
              Positioned(
                left: 12,
                top: 12,
                child: SportBadge(sport: sport),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  court['name']?.toString() ?? '',
                  style: AppTheme.displaySemi(18),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 16, color: AppTheme.muted),
                    const SizedBox(width: 4),
                    Text(
                      'Tối đa $capacity người',
                      style: AppTheme.body(size: 14, color: AppTheme.muted),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: AppTheme.displayBold(18, color: AppTheme.accent),
                    children: [
                      TextSpan(text: formatPrice(price)),
                      TextSpan(
                        text: ' /giờ',
                        style: AppTheme.body(size: 14, color: AppTheme.muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onBook,
                    child: const Text('Đặt sân'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
