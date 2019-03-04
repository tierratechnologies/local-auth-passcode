import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
// import 'package:flutter_test/flutter_test.dart' show CommonFinders;
import 'package:test/test.dart';
// import 'package:flutter_test/flutter_test.dart' show CommonFinders;

// find =CommonFinders

void main() {
  group('smoke test', () {
    FlutterDriver driver;
    final String title = 'Passcode Demo Title';
    final String resetBtnText = 'RESET';
    final int delayMS = 100;

    SerializableFinder passFormTitle = find.text(title);
    SerializableFinder resetBtn = find.text(resetBtnText);

    SerializableFinder firstInput = find.byValueKey(0);
    SerializableFinder secondInput = find.byValueKey(1);
    SerializableFinder thirdInput = find.byValueKey(2);
    SerializableFinder forthInput = find.byValueKey(3);

    String firstInputText;
    String secondInputText;
    String thirdInputText;
    String forthInputText;

    setUpAll(() async {
      driver = await FlutterDriver.connect(printCommunication: true);
    });

    setUp(() async {
      await driver.waitFor(passFormTitle);
    });

    tearDown(() async {
      firstInputText = secondInputText = thirdInputText = forthInputText = null;
      await driver.tap(resetBtn);
      await Future.delayed(Duration(milliseconds: delayMS));
    });

    tearDownAll(() async {
      if (driver != null) await driver.close();

      return null;
    });

    test('Enter text into each input field', () async {
      final String input = '1';
      bool exceptionThrown = false;

      try {
        await driver.waitFor(find.text(input),
            timeout: Duration(milliseconds: 500));
      } catch (e) {
        exceptionThrown = true;
      }

      expect(exceptionThrown, true);
      exceptionThrown = false;

      // firstInput
      await driver.enterText(input);

      try {
        await driver.waitFor(find.text(input),
            timeout: Duration(milliseconds: 500));
      } catch (e) {}

      expect(exceptionThrown, false);
      exceptionThrown = false;

      // secondInput
      await driver.enterText(input);
      await Future.delayed(Duration(milliseconds: delayMS));

      // thirdInput
      await driver.enterText(input);
      await Future.delayed(Duration(milliseconds: delayMS));

      // forthInput
      await driver.enterText(input);
      await Future.delayed(Duration(milliseconds: delayMS));

      // try {
      //   await driver.waitFor(find.text(input),
      //       timeout: Duration(milliseconds: 500));
      // } catch (e) {
      //   exceptionThrown = true;
      // }

      // expect(exceptionThrown, true);
    });

    test('Find 2nd input and enter text', () async {
      final String input = '1';
      bool exceptionThrown = false;

      try {
        await driver.waitFor(find.text(input),
            timeout: Duration(milliseconds: 500));
      } catch (e) {
        exceptionThrown = true;
      }

      expect(exceptionThrown, true);
      exceptionThrown = false;

      await driver.tap(secondInput);
      await Future.delayed(Duration(milliseconds: delayMS));
      await driver.enterText('1');

      try {
        await driver.waitFor(find.text(input),
            timeout: Duration(milliseconds: 500));
      } catch (e) {}

      expect(exceptionThrown, false);
    });
  });
}
