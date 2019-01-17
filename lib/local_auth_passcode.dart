library local_auth_passcode;

// import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

/// A Passcode Auth widget for Local Authentication.

class PasscodeAuth extends StatefulWidget {
  PasscodeAuth({
    Key key,
    // @required this.onSubmit,
  }) : super(key: key);

  // final Function onSubmit;

  @override
  _PasscodeAuthState createState() => _PasscodeAuthState();
}

class _PasscodeAuthState extends State<PasscodeAuth> {
  FocusNode _input1Focus;
  FocusNode _input2Focus;
  FocusNode _input3Focus;
  FocusNode _input4Focus;

  TextEditingController _input1Ctl;
  TextEditingController _input2Ctl;
  TextEditingController _input3Ctl;
  TextEditingController _input4Ctl;

  // List<String> _passcode = List<String>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _input1Focus = FocusNode();
    _input2Focus = FocusNode();
    _input3Focus = FocusNode();
    _input4Focus = FocusNode();

    _input1Ctl = TextEditingController();
    _input2Ctl = TextEditingController();
    _input3Ctl = TextEditingController();
    _input4Ctl = TextEditingController();

    _input1Ctl.addListener(_onChange);
    _input2Ctl.addListener(_onChange);
    _input3Ctl.addListener(_onChange);
    _input4Ctl.addListener(_onChange);
  }

  @override
  void dispose() {
    _input1Ctl.dispose();
    _input2Ctl.dispose();
    _input3Ctl.dispose();
    _input4Ctl.dispose();

    _input1Focus.dispose();
    _input2Focus.dispose();
    _input3Focus.dispose();
    _input4Focus.dispose();

    super.dispose();
  }

  String get pin =>
      '${_input1Ctl.text}${_input2Ctl.text}${_input3Ctl.text}${_input4Ctl.text}';

  void _onChange() {
    //   // if the value entered is 1 digit in length, then move focus to next input
    if (_input1Focus.hasFocus) {
      if (_input1Ctl.text.length == 1) {
        _input1Focus.unfocus();
        FocusScope.of(_formKey.currentContext).requestFocus(_input2Focus);
      }
    } else if (_input2Focus.hasFocus) {
      if (_input2Ctl.text.length == 1) {
        _input2Focus.unfocus();
        FocusScope.of(_formKey.currentContext).requestFocus(_input3Focus);
      }
    } else if (_input3Focus.hasFocus) {
      if (_input3Ctl.text.length == 1) {
        _input3Focus.unfocus();
        FocusScope.of(_formKey.currentContext).requestFocus(_input4Focus);
      }
    } else if (_input4Focus.hasFocus) {
      if (_input4Ctl.text.length == 1) {
        print('call submit from onChange() $pin');

        _formKey.currentState.reset();
        FocusScope.of(_formKey.currentContext).requestFocus(_input1Focus);
      }
    }
  }

  InputDecoration _decoration = InputDecoration(
    contentPadding: EdgeInsets.all(5.0),
    counterStyle: TextStyle(fontSize: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            // input 1
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _input1Focus,
                  autofocus: true,
                  controller: _input1Ctl,
                  // onSaved: (val) {
                  //   _passcode[0] = val;
                  // },
                  onFieldSubmitted: (val) {
                    if (_input1Ctl.text.length == 1) {
                      // _input1Focus.unfocus();
                      // FocusScope.of(context).requestFocus(_input2Focus);
                      _onChange();
                    }
                  },
                  obscureText: true,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                  enableInteractiveSelection: false,
                  decoration: _decoration,
                ),
              ),
            ),

            // // input 2
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _input2Focus,
                  controller: _input2Ctl,
                  obscureText: true,
                  // onSaved: (val) {
                  //   _passcode[1] = val;
                  // },
                  onFieldSubmitted: (val) {
                    if (_input2Ctl.text.length == 1) {
                      // _input2Focus.unfocus();
                      // FocusScope.of(context).requestFocus(_input3Focus);
                      _onChange();
                    }
                  },
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                  enableInteractiveSelection: false,
                  decoration: _decoration,
                ),
              ),
            ),

            // // input 3
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _input3Focus,
                  controller: _input3Ctl,
                  obscureText: true,
                  // onSaved: (val) {
                  //   _passcode[2] = val;
                  // },
                  onFieldSubmitted: (val) {
                    if (_input3Ctl.text.length == 1) {
                      // _input3Focus.unfocus();
                      // FocusScope.of(context).requestFocus(_input4Focus);
                      _onChange();
                    }
                  },
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                  enableInteractiveSelection: false,
                  decoration: _decoration,
                ),
              ),
            ),

            // // input 4
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  focusNode: _input4Focus,
                  controller: _input4Ctl,
                  obscureText: true,
                  // onSaved: (val) {
                  //   _passcode[3] = val;
                  // },
                  // onFieldSubmitted: (val) {
                  //   _input4Focus.unfocus();
                  //   print('call submit');
                  //   FocusScope.of(context).requestFocus(_input1Focus);
                  // },
                  onEditingComplete: () {
                    print('onEditingComplete heard');
                    if (_input4Ctl.text.length == 1) {
                      // _input4Focus.unfocus();
                      // FocusScope.of(context).requestFocus(_input1Focus);
                      _onChange();
                    }
                  },
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                  enableInteractiveSelection: false,
                  decoration: _decoration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
