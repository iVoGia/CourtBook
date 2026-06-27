import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// API base URL — override per platform.
/// iOS Simulator: http://localhost:3001
/// Android Emulator: http://10.0.2.2:3001
/// Physical device: http://<your-lan-ip>:3001
class ApiConfig {
  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:3001';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'http://10.0.2.2:3001';
      default:
        return 'http://localhost:3001';
    }
  }

  static String get apiPrefix => '$baseUrl/api';
}
