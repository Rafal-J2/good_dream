import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/bloc/timer/timer_state.dart';
import 'package:good_dream/views/widgets/timer_display_widget.dart';

void main() {
  Widget createWidgetUnderTest(TimerState state) {
    return MaterialApp(
      home: Scaffold(
        body: TimerDisplayWidget(state: state),
      ),
    );
  }

  group('TimerDisplayWidget Tests', () {
    testWidgets('should display 00:00:00 when remainingTime is 0', (WidgetTester tester) async {
      const state = TimerState(remainingTime: 0);
      await tester.pumpWidget(createWidgetUnderTest(state));

      expect(find.text('00:00:00'), findsOneWidget);
    });

    testWidgets('should format properly for seconds and minutes (e.g. 65 seconds -> 00:01:05)', (WidgetTester tester) async {
      const state = TimerState(remainingTime: 65);
      await tester.pumpWidget(createWidgetUnderTest(state));

      expect(find.text('00:01:05'), findsOneWidget);
    });

    testWidgets('should format properly for hours (e.g. 3665 seconds -> 01:01:05)', (WidgetTester tester) async {
      const state = TimerState(remainingTime: 3665);
      await tester.pumpWidget(createWidgetUnderTest(state));

      expect(find.text('01:01:05'), findsOneWidget);
    });
  });
}
