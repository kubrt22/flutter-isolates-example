import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:isolates/isolate.dart';
import 'package:isolates/screen.dart';

void main() {
  test('hardComputation completes and returns the sum', () {
    expect(hardComputation(iterations: 0), 0);
    expect(hardComputation(iterations: 1), 0);
    expect(hardComputation(iterations: 10), 45);
    expect(hardComputation(iterations: 5555), 15426235);
  });

  test('hardComputation reports a positive elapsed time', () async {
    final result = await runWithIsolate(iterations: 10000000);

    expect(result.inMicroseconds, greaterThan(0));
  });

  testWidgets('Screen displays controls and initial result text', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: Screen()));

    expect(find.text('UI Vlákno'), findsOneWidget);
    expect(find.text('Isolate'), findsOneWidget);
    expect(find.text('nic'), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });
}
