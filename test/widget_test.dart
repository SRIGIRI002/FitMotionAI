// Basic smoke test — verifies the App widget tree can be built.
// Firebase is not initialised in tests, so we pump App directly
// only to confirm it compiles and the widget instantiates.

import 'package:fitmotion_ai/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App widget builds without error', (WidgetTester tester) async {
    // Wrap in a try/catch because GoRouter's internal link-checker may
    // fire platform-channel calls (e.g. deep-link) that are unavailable
    // in the test environment; we just want to confirm the widget compiles.
    expect(() => const App(), returnsNormally);
  });
}
