import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:local_auth_passcode/local_auth_passcode.dart';

void main() {
  testWidgets('builds passcode form with 4 textform fields',
      (WidgetTester tester) async {
    PasscodeAuth childWidget = PasscodeAuth();

    Widget builder() {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Material(child: childWidget),
        ),
      );
    }

    await tester.pumpWidget(builder());

    // find the Passcode Widget
    expect(find.byWidget(childWidget), findsOneWidget);

    // find the 4 input fieds
    expect(find.byType(TextFormField), findsNWidgets(4));

    // ensure the first input has focus
    
  });
}
