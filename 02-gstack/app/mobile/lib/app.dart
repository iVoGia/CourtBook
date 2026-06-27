import 'package:flutter/material.dart';

import 'core/api/api_client.dart';
import 'core/theme/app_theme.dart';
import 'features/account/account_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/bookings/bookings_screen.dart';
import 'features/courts/courts_screen.dart';
import 'features/admin/admin_bookings_screen.dart';

class CourtBookApp extends StatefulWidget {
  const CourtBookApp({super.key, required this.api});

  final ApiClient api;

  @override
  State<CourtBookApp> createState() => _CourtBookAppState();
}

class _CourtBookAppState extends State<CourtBookApp> {
  bool _checking = true;
  bool _loggedIn = false;
  Map<String, dynamic>? _user;
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      await widget.api.get('/health');
    } catch (_) {}
    final token = await widget.api.getToken();
    final user = await widget.api.getStoredUser();
    _loggedIn = token != null;
    _user = user;
    if (mounted) setState(() => _checking = false);
  }

  Future<void> _logout() async {
    try {
      await widget.api.post('/auth/logout', auth: true);
    } catch (_) {}
    await widget.api.setSession(null, null);
    setState(() {
      _loggedIn = false;
      _user = null;
      _navIndex = 0;
    });
  }

  bool get _isAdmin => _user?['role'] == 'admin';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CourtBook',
      theme: AppTheme.light(),
      home: _checking
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : !_loggedIn
              ? LoginScreen(
                  api: widget.api,
                  onSuccess: () async {
                    final user = await widget.api.getStoredUser();
                    setState(() {
                      _loggedIn = true;
                      _user = user;
                    });
                  },
                )
              : _isAdmin
                  ? AdminBookingsScreen(
                      api: widget.api,
                      user: _user,
                      onLogout: _logout,
                      onUserUpdated: (u) => setState(() => _user = u),
                    )
                  : _UserShell(
                      api: widget.api,
                      user: _user,
                      index: _navIndex,
                      onIndexChanged: (i) => setState(() => _navIndex = i),
                      onLogout: _logout,
                      onUserUpdated: (u) => setState(() => _user = u),
                    ),
    );
  }
}

class _UserShell extends StatelessWidget {
  const _UserShell({
    required this.api,
    required this.user,
    required this.index,
    required this.onIndexChanged,
    required this.onLogout,
    required this.onUserUpdated,
  });

  final ApiClient api;
  final Map<String, dynamic>? user;
  final int index;
  final ValueChanged<int> onIndexChanged;
  final VoidCallback onLogout;
  final ValueChanged<Map<String, dynamic>> onUserUpdated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          CourtsScreen(api: api),
          BookingsScreen(
            api: api,
            onBrowseCourts: () => onIndexChanged(0),
          ),
          AccountScreen(
            api: api,
            user: user,
            onLogout: onLogout,
            onUserUpdated: onUserUpdated,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: onIndexChanged,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.sports_tennis), label: 'Sân'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Lịch đặt'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
