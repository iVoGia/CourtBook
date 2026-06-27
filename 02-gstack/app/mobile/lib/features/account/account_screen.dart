import 'package:flutter/material.dart';

import '../../core/api/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/format.dart';
import '../../core/widgets/app_page_header.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/info_row.dart';
import '../../core/widgets/sport_badge.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
    required this.api,
    this.user,
    required this.onLogout,
    this.onUserUpdated,
    this.showBackButton = false,
  });

  final ApiClient api;
  final Map<String, dynamic>? user;
  final VoidCallback onLogout;
  final ValueChanged<Map<String, dynamic>>? onUserUpdated;
  final bool showBackButton;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic>? _user;
  bool _refreshing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _refresh();
  }

  @override
  void didUpdateWidget(AccountScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user != oldWidget.user) {
      _user = widget.user;
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _refreshing = true;
      _error = null;
    });
    try {
      final stored = await widget.api.getStoredUser();
      if (stored != null && mounted) setState(() => _user = stored);

      final res = await widget.api.get('/auth/me', auth: true);
      final user = res['user'] as Map<String, dynamic>?;
      if (user != null) {
        final token = await widget.api.getToken();
        await widget.api.setSession(token, user);
        if (mounted) setState(() => _user = user);
        widget.onUserUpdated?.call(user);
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  String get _initial {
    final name = _user?['name']?.toString() ?? '?';
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showBackButton
          ? AppBar(title: const Text('Tài khoản'))
          : null,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              if (!widget.showBackButton)
                AppPageHeader(
                  title: 'Tài khoản',
                  subtitle: 'Giới thiệu ứng dụng và thông tin của bạn',
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _AppIntroCard(),
                    const SizedBox(height: 16),
                    _UserInfoCard(
                      user: _user,
                      initial: _initial,
                      refreshing: _refreshing,
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Text(_error!, style: const TextStyle(color: AppTheme.danger)),
                    ],
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: widget.onLogout,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.danger,
                        side: const BorderSide(color: AppTheme.danger),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text('Đăng xuất'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppIntroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.surfaceMuted,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const AppLogo(size: 72),
            const SizedBox(height: 16),
            Text('CourtBook', style: AppTheme.displayBold(24, color: AppTheme.primary)),
            const SizedBox(height: 6),
            Text(
              'Đặt sân chỉ trong vài giây',
              style: AppTheme.body(size: 14, color: AppTheme.muted),
            ),
            const SizedBox(height: 16),
            Text(
              'Ứng dụng đặt sân thể thao trực tuyến. Xem sân còn trống, '
              'gửi yêu cầu đặt, theo dõi lịch sắp tới và hủy đặt theo chính sách 24 giờ.',
              textAlign: TextAlign.center,
              style: AppTheme.body(size: 14, color: AppTheme.muted),
            ),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                SportBadge(sport: 'badminton'),
                SportBadge(sport: 'mini_football'),
                SportBadge(sport: 'tennis'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  const _UserInfoCard({
    required this.user,
    required this.initial,
    required this.refreshing,
  });

  final Map<String, dynamic>? user;
  final String initial;
  final bool refreshing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.primary.withValues(alpha: 0.15),
                  foregroundColor: AppTheme.primary,
                  child: Text(initial, style: AppTheme.displayBold(22, color: AppTheme.primary)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thông tin tài khoản', style: AppTheme.displaySemi(16)),
                      if (refreshing)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppTheme.primary.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InfoRow(label: 'Họ tên', value: user?['name']?.toString() ?? '—'),
            InfoRow(label: 'Email', value: user?['email']?.toString() ?? '—'),
            InfoRow(
              label: 'Vai trò',
              value: roleLabel(user?['role']?.toString() ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
