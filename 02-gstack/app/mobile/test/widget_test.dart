import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/api/api_client.dart';
import 'package:mobile/features/auth/login_screen.dart';

void main() {
  testWidgets('Login screen renders CourtBook', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(api: ApiClient(), onSuccess: () {}),
      ),
    );
    expect(find.text('CourtBook'), findsOneWidget);
    expect(find.text('Đăng nhập'), findsOneWidget);
  });
}
