import 'package:flutter/material.dart';

import '../../core/api/api_client.dart';
import '../../core/config/api_config.dart';
import '../../core/theme/app_theme.dart';

/// Home — mirror main web dashboard flow. Extend per docs/api-spec.md.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.api, required this.onLogout});

  final ApiClient api;
  final VoidCallback onLogout;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _health;
  String? _error;
  bool _loading = true;

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
      final health = await widget.api.get('/health');
      setState(() => _health = health);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contest Mobile'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _load),
          IconButton(icon: const Icon(Icons.logout), onPressed: widget.onLogout),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('API: ${ApiConfig.apiPrefix}', style: TextStyle(color: AppTheme.muted, fontSize: 12)),
                  const SizedBox(height: 16),
                  if (_error != null)
                    Text(_error!, style: const TextStyle(color: Colors.redAccent))
                  else ...[
                    Text('Kết nối API OK', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primary)),
                    const SizedBox(height: 8),
                    Text(_health.toString(), style: const TextStyle(fontSize: 13)),
                  ],
                  const SizedBox(height: 24),
                  const Text('TODO: implement MVP screens mirroring web flow (see docs/api-spec.md)'),
                ],
              ),
            ),
    );
  }
}
