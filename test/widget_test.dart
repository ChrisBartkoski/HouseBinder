import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:house_binder/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: HouseBinderApp(),
      ),
    );

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing
    // The app should show either onboarding or the main shell
    expect(find.byType(HouseBinderApp), findsOneWidget);
  });
}
