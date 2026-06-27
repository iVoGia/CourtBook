import 'package:flutter/material.dart';

import '../../core/api/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/status_pill.dart';
import '../account/account_screen.dart';

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({
    super.key,
    required this.api,
    this.user,
    this.onLogout,
    this.onUserUpdated,
  });

  final ApiClient api;
  final Map<String, dynamic>? user;
  final VoidCallback? onLogout;
  final ValueChanged<Map<String, dynamic>>? onUserUpdated;

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
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
      final list = await widget.api.getList('/admin/bookings?filter=$_tab', auth: true);
      setState(() => _bookings = list);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _action(int id, String action) async {
    try {
      await widget.api.patch('/admin/bookings/$id', auth: true, body: {'action': action});
      _load();
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đặt sân'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AccountScreen(
                    api: widget.api,
                    user: widget.user,
                    onLogout: widget.onLogout ?? () {},
                    onUserUpdated: widget.onUserUpdated,
                    showBackButton: true,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.person_outline),
            tooltip: 'Tài khoản',
          ),
        ],
      ),
      body: Column(
        children: [
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
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _bookings.length,
                    itemBuilder: (context, i) {
                      final b = _bookings[i] as Map<String, dynamic>;
                      final status = b['status']?.toString() ?? '';
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
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
                              const SizedBox(height: 6),
                              Text(
                                '${b['booking_date']} · ${b['start_time']}',
                                style: AppTheme.body(size: 13, color: AppTheme.muted),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${b['user_name']} · ${b['customer_name']}',
                                style: AppTheme.body(size: 13),
                              ),
                              if (status == 'pending' && _tab == 'upcoming') ...[
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => _action(b['id'] as int, 'confirm'),
                                        child: const Text('Xác nhận'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => _action(b['id'] as int, 'reject'),
                                        child: const Text('Từ chối'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
