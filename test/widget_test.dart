import 'package:flutter_test/flutter_test.dart';

import 'package:matchup/app/app.dart';

void main() {
  testWidgets('MatchUP app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MatchUPApp());

    expect(find.text('MatchUP'), findsOneWidget);
  });
}