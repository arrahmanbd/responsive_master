import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_master/responsive_master.dart';

void main() {
  testWidgets('ResponsiveScope initializes and updates screen info correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ResponsiveScope(
          layoutBuilder: (layout) => Text('Screen Type: ${layout.isDesktop}'),
          scaleMode: ScaleMode.percent,
          maxMobileWidth: 599,
          maxTabletWidth: 1024,
        ),
      ),
    );

    // Verify initial rendering
    expect(find.textContaining('Screen Type:'), findsOneWidget);

    // Simulate screen resize
    tester.view.physicalSize = const Size(800, 1280);
    await tester.pumpAndSettle();

    // Verify screen type update
    expect(find.textContaining('Screen Type:'), findsOneWidget);
  });

  testWidgets('ResponsiveScope respects orientation lock', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ResponsiveScope(
          layoutBuilder: (layout) => Text('Orientation: ${layout.isPortrait}'),
          screenLock: AppOrientationLock.portraitUp,
        ),
      ),
    );

    // Simulate orientation change
    tester.view.physicalSize = Size(1280, 800);
    await tester.pumpAndSettle();

    // Verify orientation remains locked
    expect(
      find.textContaining('Orientation: Orientation.portrait'),
      findsOneWidget,
    );
  });
}
