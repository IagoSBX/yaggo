import 'package:flutter_test/flutter_test.dart';
import 'package:yaggo/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const YaggoApp());
    expect(find.text('YAG-GO'), findsWidgets);
  });
}
