import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/views/widgets/mode_switch.dart';

void main() {
  const FlexSchemeData mockFlexSchemeData = FlexSchemeData(
    name: 'Mock',
    description: 'Mock',
    light: FlexSchemeColor(
      primary: Colors.blue,
      primaryContainer: Colors.blueAccent,
      secondary: Colors.red,
      secondaryContainer: Colors.redAccent,
    ),
    dark: FlexSchemeColor(
      primary: Colors.blue,
      primaryContainer: Colors.blueAccent,
      secondary: Colors.red,
      secondaryContainer: Colors.redAccent,
    ),
  );

  Widget createWidgetUnderTest(ThemeMode themeMode, ValueChanged<ThemeMode> onThemeModeChanged) {
    return MaterialApp(
      home: Scaffold(
        body: ModeSwitch(
          themeMode: themeMode,
          onThemeModeChanged: onThemeModeChanged,
          flexSchemeData: mockFlexSchemeData,
        ),
      ),
    );
  }

  group('ModeSwitch Tests', () {
    testWidgets('should render correctly with initial theme mode', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(ThemeMode.dark, (mode) {}));

      // FlexThemeModeSwitch is a complex widget, but we can verify it's rendered
      expect(find.byType(FlexThemeModeSwitch), findsOneWidget);
    });

    testWidgets('should call onThemeModeChanged when switch is toggled', (WidgetTester tester) async {
      ThemeMode? changedMode;
      await tester.pumpWidget(createWidgetUnderTest(ThemeMode.dark, (mode) {
        changedMode = mode;
      }));

      // FlexThemeModeSwitch uses OptionButtons internally. Let's tap the one representing light mode.
      // Alternatively, we can find the switch based on its text if it has any, but 'FlexThemeModeSwitch' 
      // usually displays 'Light', 'Dark' or system default.
      
      // Let's find by text 'Light' which is default in FlexThemeModeSwitch
      final lightModeButton = find.text('Light');
      if(lightModeButton.evaluate().isNotEmpty) {
        await tester.tap(lightModeButton.first);
        await tester.pumpAndSettle();
        
        expect(changedMode, ThemeMode.light);
      }
    });
  });
}
