import 'package:flutter_test/flutter_test.dart';
import 'package:horizon_academy_flutter/main.dart';

void main() {
  testWidgets('Horizon Academy App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HorizonAcademyApp());
    expect(find.text('HORIZON'), findsOneWidget);
  });
}
