import 'package:flutter/material.dart';

import '../../core/api/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_page_header.dart';
import '../../core/widgets/court_card.dart';
import '../../core/widgets/filter_chip_row.dart';
import '../../core/widgets/skeleton_court_card.dart';
import 'book_court_screen.dart';

class CourtsScreen extends StatefulWidget {
  const CourtsScreen({super.key, required this.api});

  final ApiClient api;

  @override
  State<CourtsScreen> createState() => _CourtsScreenState();
}

class _CourtsScreenState extends State<CourtsScreen> {
  static const _filters = [
    (id: 'all', label: 'Tất cả'),
    (id: 'badminton', label: 'Cầu lông'),
    (id: 'mini_football', label: 'Mini football'),
    (id: 'tennis', label: 'Tennis'),
  ];

  String _sport = 'all';
  List<dynamic> _courts = [];
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
      final q = _sport == 'all' ? '' : '?sport=$_sport';
      final courts = await widget.api.getList('/courts$q');
      setState(() => _courts = courts);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: AppPageHeader(
                  title: 'Danh sách sân',
                  subtitle: 'Chọn sân phù hợp và đặt trong vài giây',
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: FilterChipRow(
                    options: _filters,
                    selected: _sport,
                    onSelected: (id) {
                      setState(() => _sport = id);
                      _load();
                    },
                  ),
                ),
              ),
              if (_error != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(_error!, style: const TextStyle(color: AppTheme.danger)),
                  ),
                ),
              if (_loading)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: SkeletonCourtCard(),
                      ),
                      childCount: 3,
                    ),
                  ),
                )
              else if (_courts.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sports, size: 48, color: AppTheme.muted.withValues(alpha: 0.5)),
                        const SizedBox(height: 12),
                        Text('Không có sân nào', style: AppTheme.body(color: AppTheme.muted)),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final c = _courts[i] as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CourtCard(
                            court: c,
                            onBook: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BookCourtScreen(api: widget.api, court: c),
                                ),
                              );
                              _load();
                            },
                          ),
                        );
                      },
                      childCount: _courts.length,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
