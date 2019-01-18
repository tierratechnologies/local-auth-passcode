library local_auth_passcode;

// import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

/// A Passcode Auth widget for Local Authentication.

class PasscodeAuth extends StatefulWidget {
  PasscodeAuth({
    Key key,
    this.inputLength = 4,
    // @required this.onSubmit,
  }) : super(key: key);

  // final Function onSubmit;
  final int inputLength;

  @override
  _PasscodeAuthState createState() => _PasscodeAuthState();
}

class _PasscodeAuthState extends State<PasscodeAuth> {
  List<FocusNode> _focusNodes;

  List<TextEditingController> _txtCtlrs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _buildFocusNodes();

    _buildTextEditingControllers(listener: _onChange);
  }

  @override
  void dispose() {
    // disponse text editing controllers
    _txtCtlrs.forEach((TextEditingController ctlr) => ctlr.dispose());

    // dispose focus nodes
    _focusNodes.forEach((FocusNode node) => node.dispose());

    super.dispose();
  }

  void _buildFocusNodes() {
    _focusNodes = List.generate(widget.inputLength, (_) => FocusNode());
  }

  void _buildTextEditingControllers({Function listener}) {
    _txtCtlrs =
        List.generate(widget.inputLength, (_) => TextEditingController());

    if (listener != null) {
      _txtCtlrs
          .forEach((TextEditingController ctlr) => ctlr.addListener(listener));
    }
  }

  String get pin =>
      _txtCtlrs.map((TextEditingController ctlr) => ctlr.text).toList().join();

  void _onChange() {
    int index;
    TextEditingController ctlr;

    FocusNode focusNodeInFocus = _focusNodes
        .firstWhere((FocusNode node) => node.hasFocus, orElse: () => null);

    if (focusNodeInFocus != null) {
      index = _focusNodes.indexOf(focusNodeInFocus);
      ctlr = _txtCtlrs.elementAt(index);
    }

    if (ctlr != null && ctlr.text.length == 1) {
      // set focus on next node
      int nextIndex = index == widget.inputLength - 1 ? 0 : index + 1;
      FocusNode nextFocusNode = _focusNodes.elementAt(nextIndex);
      FocusScope.of(_formKey.currentContext).requestFocus(nextFocusNode);

      // if on last elements, reset the form
      if (index == widget.inputLength - 1) {
        print('call submit from onChange() $pin');

        _formKey.currentState.reset();
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

  Widget _buildInputField({
    BuildContext context,
    bool autofocus = false,
    Function onFieldSubmitted,
    FocusNode focusNode,
    TextEditingController textEditingController,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: TextFormField(
          enabled: false,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.none,
          focusNode: focusNode,
          autofocus: autofocus,
          controller: textEditingController,
          onFieldSubmitted: (_) {
            if (textEditingController.text.length == 1) {
              onFieldSubmitted.call();
            }
          },
          obscureText: true,
          maxLength: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.display1.fontSize,
            color: Theme.of(context).textTheme.display1.color,
          ),
          enableInteractiveSelection: false,
          decoration: _decoration,
        ),
      ),
    );
  }

  List<Widget> _buildRowChildren(BuildContext context) => List<Widget>.generate(
      widget.inputLength,
      (int index) => _buildInputField(
            context: context,
            autofocus: index == 0 ? true : false,
            onFieldSubmitted: () => _onChange,
            focusNode: _focusNodes.elementAt(index),
            textEditingController: _txtCtlrs.elementAt(index),
          ));

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
          children: _buildRowChildren(context),
        ),
      ),
    );
  }
}
