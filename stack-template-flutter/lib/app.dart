import 'package:flutter/material.dart';

import '../core/api/api_client.dart';
import '../core/theme/app_theme.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';

class ContestApp extends StatefulWidget {
  const ContestApp({super.key, required this.api});

  final ApiClient api;

  @override
  State<ContestApp> createState() => _ContestAppState();
}

class _ContestAppState extends State<ContestApp> {
  bool _checking = true;
  bool _loggedIn = false;
  bool _requiresAuth = false; // set true when BA_BRIEF has login

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      await widget.api.get('/health');
    } catch (_) {}
    if (_requiresAuth) {
      final token = await widget.api.getToken();
      _loggedIn = token != null;
    } else {
      _loggedIn = true;
    }
    if (mounted) setState(() => _checking = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contest Mobile',
      theme: AppTheme.dark(),
      home: _checking
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : _loggedIn
              ? HomeScreen(api: widget.api, onLogout: _logout)
              : LoginScreen(api: widget.api, onSuccess: () => setState(() => _loggedIn = true)),
    );
  }

  Future<void> _logout() async {
    await widget.api.setToken(null);
    setState(() => _loggedIn = false);
  }
}
