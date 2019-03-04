import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:local_auth_passcode/local_auth_passcode.dart';

void main() {
  testWidgets(
      'builds passcode form with 4 textform fields and has set focus on first',
      (WidgetTester tester) async {
    // mock submit handler
    Function submitHandler = (String pin) {
      print('PIN: $pin');
      return;
    };

    PasscodeAuth childWidget = PasscodeAuth(
      titleText: Text('PasscodeAuth Test'),
      onSubmit: submitHandler,
    );

    Widget builder() {
      return MaterialApp(
        title: 'LocalAuth Passcode',
        home: Scaffold(
          body: Center(child: childWidget),
        ),
      );
    }

    await tester.pumpWidget(builder());

    // find the Passcode Widget
    expect(find.byWidget(childWidget), findsOneWidget);

    // find the 4 input fieds
    expect(find.byType(TextField), findsNWidgets(4));

    // ensure the first input has focus & then enter a value via the keyboard
    expect(find.byType(TextField).first, findsOneWidget);

    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.focusNode.hasFocus == true),
        findsOneWidget);
  });

// 'calls onSubmit and sets PIN value after all inputs completed'
  testWidgets('moves focus to next input when value set',
      (WidgetTester tester) async {
    // String _pin;

    Function submitHandler = (String pin) {
      // _pin = pin;
      print(pin);
      return;
    };

    PasscodeAuth childWidget = PasscodeAuth(
      titleText: Text('PasscodeAuth Test'),
      onSubmit: submitHandler,
    );

    Widget builder() {
      return MaterialApp(
        title: 'LocalAuth Passcode',
        home: Scaffold(
          body: Center(child: childWidget),
        ),
      );
    }

    await tester.pumpWidget(builder());

    await tester.enterText(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.focusNode.hasFocus == true),
        '1');

    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField &&
            widget.controller.text.length == 1 &&
            widget.focusNode.hasFocus == false),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField &&
            widget.focusNode.hasFocus == true &&
            widget.controller.text.length == 0),
        findsOneWidget);
  });
}
