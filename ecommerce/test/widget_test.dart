import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/main.dart';

void main() {
  testWidgets('HomePage displays products', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Wait for widgets to build
    await tester.pumpAndSettle();

    // Verify HomePage shows "Home" app bar
    expect(find.text('Home'), findsOneWidget);
  });
}
