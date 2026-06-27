import 'package:flutter/material.dart';

import '../../core/api/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/court_image.dart';
import '../../core/widgets/sport_badge.dart';
import '../../core/utils/format.dart';

class BookCourtScreen extends StatefulWidget {
  const BookCourtScreen({super.key, required this.api, required this.court});

  final ApiClient api;
  final Map<String, dynamic> court;

  @override
  State<BookCourtScreen> createState() => _BookCourtScreenState();
}

class _BookCourtScreenState extends State<BookCourtScreen> {
  late String _date;
  int _duration = 1;
  List<dynamic> _slots = [];
  Map<String, dynamic>? _selectedSlot;
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _players = TextEditingController(text: '2');
  bool _loadingSlots = true;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _date = _formatDate(DateTime.now().add(const Duration(days: 1)));
    _loadSlots();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _players.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _loadSlots() async {
    setState(() => _loadingSlots = true);
    try {
      final res = await widget.api.get(
        '/courts/${widget.court['id']}/slots?date=$_date&duration=$_duration',
      );
      setState(() {
        _slots = res['slots'] as List<dynamic>? ?? [];
        _selectedSlot = null;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loadingSlots = false);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_date),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked != null) {
      setState(() => _date = _formatDate(picked));
      _loadSlots();
    }
  }

  Future<void> _submit() async {
    if (_selectedSlot == null || _name.text.isEmpty || _phone.text.isEmpty) return;
    setState(() {
      _error = null;
      _submitting = true;
    });
    try {
      await widget.api.post(
        '/bookings',
        auth: true,
        body: {
          'court_id': widget.court['id'],
          'booking_date': _date,
          'start_time': _selectedSlot!['start_time'],
          'duration': _duration,
          'customer_name': _name.text.trim(),
          'phone': _phone.text.trim(),
          'player_count': int.tryParse(_players.text) ?? 2,
        },
      );
      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Yêu cầu đã gửi — chờ quản trị viên xác nhận')),
        );
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sport = widget.court['sport_type']?.toString() ?? '';
    final price = (widget.court['hourly_price'] as num? ?? 0) * _duration;
    final capacity = widget.court['capacity'] as int? ?? 4;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CourtImage(court: widget.court, expand: true),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.1),
                                Colors.black.withValues(alpha: 0.55),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SportBadge(sport: sport),
                              const SizedBox(height: 8),
                              Text(
                                widget.court['name']?.toString() ?? '',
                                style: AppTheme.displayBold(22, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Text('Thời lượng', style: AppTheme.displaySemi(16)),
                      const SizedBox(height: 8),
                      Row(
                        children: [1, 2, 3].map((h) {
                          final selected = _duration == h;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text('$h giờ'),
                              selected: selected,
                              selectedColor: AppTheme.primary.withValues(alpha: 0.15),
                              labelStyle: TextStyle(
                                color: selected ? AppTheme.primary : AppTheme.muted,
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) {
                                setState(() => _duration = h);
                                _loadSlots();
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Ngày đặt', style: AppTheme.displaySemi(16)),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: _pickDate,
                            icon: const Icon(Icons.calendar_today, size: 18),
                            label: Text(_date),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_loadingSlots)
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _slots.map((s) {
                            final slot = s as Map<String, dynamic>;
                            final available = slot['available'] == true;
                            final selected = _selectedSlot?['start_time'] == slot['start_time'];
                            return FilterChip(
                              label: Text(slot['start_time']?.toString() ?? ''),
                              selected: selected,
                              showCheckmark: false,
                              selectedColor: AppTheme.primary,
                              labelStyle: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : available
                                        ? AppTheme.onBackground
                                        : AppTheme.muted,
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: available
                                  ? (_) => setState(() => _selectedSlot = slot)
                                  : null,
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 24),
                      Text('Thông tin đặt', style: AppTheme.displaySemi(16)),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _name,
                        decoration: const InputDecoration(labelText: 'Tên khách hàng'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _phone,
                        decoration: const InputDecoration(labelText: 'Số điện thoại'),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _players,
                        decoration: InputDecoration(labelText: 'Số người (tối đa $capacity)'),
                        keyboardType: TextInputType.number,
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Text(_error!, style: const TextStyle(color: AppTheme.danger)),
                      ],
                      const SizedBox(height: 100),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + MediaQuery.paddingOf(context).bottom),
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              border: Border(top: BorderSide(color: AppTheme.border)),
              boxShadow: [
                BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, -2)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Tổng cộng', style: AppTheme.label()),
                      Text(formatPrice(price), style: AppTheme.displayBold(20, color: AppTheme.accent)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitting || _selectedSlot == null ? null : _submit,
                    child: Text(_submitting ? 'Đang gửi…' : 'Gửi yêu cầu'),
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
