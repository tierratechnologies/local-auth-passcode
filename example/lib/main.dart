import 'package:flutter/material.dart';
import 'package:local_auth_passcode/local_auth_passcode.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passcode Auth Demo App',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.blue,
      // ),
      theme: ThemeData.dark(),
      home: PasscodeAuthDemo(title: 'Passcode Auth Demo'),
    );
  }
}

class PasscodeAuthDemo extends StatefulWidget {
  PasscodeAuthDemo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PasscodeAuthDemoState createState() => _PasscodeAuthDemoState();
}

class _PasscodeAuthDemoState extends State<PasscodeAuthDemo> {
  // def a onSubmit handler fn
  void _onSubmitHandler(String pin) {
    print('_onSubmitHandler heard: $pin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: PasscodeAuth(
          onSubmit: _onSubmitHandler,
          titleText: Text(
            'Passcode Demo Title',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
