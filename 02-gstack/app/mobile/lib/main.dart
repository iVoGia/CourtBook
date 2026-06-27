import 'package:flutter/material.dart';

import 'app.dart';
import 'core/api/api_client.dart';

void main() {
  runApp(CourtBookApp(api: ApiClient()));
}
