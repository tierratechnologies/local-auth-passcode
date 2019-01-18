import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:local_auth_passcode/local_auth_passcode.dart';

void main() {
  testWidgets('builds passcode form with 4 textform fields',
      (WidgetTester tester) async {
    Function submitHandler = (String pin) {
      print('PIN: $pin');
      return;
    };

    PasscodeAuth childWidget = PasscodeAuth(
      onSubmit: submitHandler,
    );

    Widget builder() {
      return MaterialApp(
        title: 'LocalAuth Passcode',
        home: Scaffold(
          body: Center(
            child: PasscodeAuth(
              onSubmit: submitHandler,
            ),
          ),
        ),
      );
    }

    await tester.pumpWidget(builder());

    // find the Passcode Widget
    // expect(find.byWidget(childWidget), findsOneWidget);

    // find the 4 input fieds
    expect(find.byType(TextFormField), findsNWidgets(4));

    // ensure the first input has focus & then enter a value via the keyboard
  });
}
