import 'package:flutter/material.dart';

import '../../core/api/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/court_images.dart';
import '../../core/utils/format.dart';
import '../../core/widgets/app_page_header.dart';
import '../../core/widgets/status_pill.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({
    super.key,
    required this.api,
    this.onBrowseCourts,
  });

  final ApiClient api;
  final VoidCallback? onBrowseCourts;

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String _tab = 'upcoming';
  List<dynamic> _bookings = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list = await widget.api.getList('/bookings?filter=$_tab', auth: true);
      setState(() => _bookings = list);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _cancel(int id) async {
    try {
      await widget.api.delete('/bookings/$id', auth: true);
      _load();
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPageHeader(
              title: 'Lịch đặt của tôi',
              subtitle: 'Theo dõi và quản lý các lịch đặt sân',
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'upcoming', label: Text('Sắp tới')),
                  ButtonSegment(value: 'past', label: Text('Đã qua')),
                ],
                selected: {_tab},
                onSelectionChanged: (s) {
                  setState(() => _tab = s.first);
                  _load();
                },
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(_error!, style: const TextStyle(color: AppTheme.danger)),
              ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: _bookings.isEmpty
                          ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                const SizedBox(height: 64),
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 56,
                                  color: AppTheme.muted.withValues(alpha: 0.4),
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: Text(
                                    'Chưa có lịch đặt',
                                    style: AppTheme.body(color: AppTheme.muted),
                                  ),
                                ),
                                if (widget.onBrowseCourts != null) ...[
                                  const SizedBox(height: 16),
                                  Center(
                                    child: OutlinedButton(
                                      onPressed: widget.onBrowseCourts,
                                      child: const Text('Xem danh sách sân'),
                                    ),
                                  ),
                                ],
                              ],
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                              itemCount: _bookings.length,
                              itemBuilder: (context, i) {
                                final b = _bookings[i] as Map<String, dynamic>;
                                final status = b['status']?.toString() ?? '';
                                final canCancel = _tab == 'upcoming' &&
                                    (status == 'pending' || status == 'confirmed');
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            CourtImages.assetForSport(
                                              b['sport_type']?.toString(),
                                            ),
                                            width: 56,
                                            height: 56,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => Image.asset(
                                              CourtImages.placeholder,
                                              width: 56,
                                              height: 56,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      b['court_name']?.toString() ?? '',
                                                      style: AppTheme.displaySemi(16),
                                                    ),
                                                  ),
                                                  StatusPill(status: status),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${b['booking_date']} · ${b['start_time']}–${b['end_time']}',
                                                style: AppTheme.body(size: 13, color: AppTheme.muted),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                formatPrice(b['total_price'] ?? 0),
                                                style: AppTheme.displayBold(16, color: AppTheme.accent),
                                              ),
                                              if (canCancel)
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextButton(
                                                    onPressed: () => _cancel(b['id'] as int),
                                                    child: const Text(
                                                      'Hủy đặt',
                                                      style: TextStyle(color: AppTheme.danger),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
