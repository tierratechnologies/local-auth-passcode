library local_auth_passcode;

// import 'package:meta/meta.dart';
import 'dart:async';

import 'package:flutter/material.dart';

const SET_NEXTORPREVIOUS_FOCUS_DELAY_MS = 50; // milliseconds

/// A Passcode Auth widget for Local Authentication.

class PasscodeAuth extends StatefulWidget {
  PasscodeAuth({
    Key key,
    this.inputLength = 4,
    @required this.onSubmit,
    @required this.titleText,
  }) : super(key: key);

  final Function onSubmit;
  final int inputLength;
  final Text titleText;

  @override
  _PasscodeAuthState createState() => _PasscodeAuthState();
}

class _PasscodeAuthState extends State<PasscodeAuth> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _txtCtlrs;
  String _pin;

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
  }

  void _onChange({
    TextEditingController txtCtlr,
    FocusNode focusNodeInFocus,
    int index,
    BuildContext context,
    // move to the nextOrPrevious element (right/forward) OR to previous (left/backwards)
    bool nextOrPrevious = true,
  }) {
    if (txtCtlr.text.length == 1) {
      // set focus on nextOrPrevious node
      int nextOrPreviousIndex = (index == widget.inputLength - 1)
          ? 0
          : nextOrPrevious ? index + 1 : index - 1;
      FocusNode nextOrPreviousFocusNode =
          _focusNodes.elementAt(nextOrPreviousIndex);

      // add a slight delay for UI polish
      Future.delayed(
        Duration(milliseconds: SET_NEXTORPREVIOUS_FOCUS_DELAY_MS),
        () {
          FocusScope.of(context).requestFocus(nextOrPreviousFocusNode);

          // if on last elements, reset the form
          if (nextOrPrevious && index == widget.inputLength - 1) {
            _pin = _txtCtlrs
                .map((TextEditingController ctlr) => ctlr.text)
                .toList()
                .join();

            reset(context);

            _submit(_pin);
          }
        },
      );
    }
  }

  void _submit(String pin) {
    assert(widget.onSubmit != null);

    widget.onSubmit.call(_pin);
  }

// Public API
  void reset(BuildContext context) {
    if (mounted != true) return;

    _txtCtlrs.forEach((TextEditingController ctlr) => ctlr.clear());

    // check that first input has focus
//    FocusScope.of(context).requestFocus(FocusNode());
//
//    Future.delayed(Duration(milliseconds: 50),
//        () => FocusScope.of(context).requestFocus(_focusNodes.first));

    FocusScope.of(context).requestFocus(_focusNodes.first);
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
    int elementIndex,
    FocusNode focusNode,
    TextEditingController textEditingController,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: TextField(
          key: ValueKey(elementIndex),
          // enabled: false,
          keyboardType: TextInputType.number,
          textInputAction: elementIndex == widget.inputLength - 1
              ? TextInputAction.done
              : TextInputAction.next,
          focusNode: focusNode,
          autofocus: autofocus,
          controller: textEditingController,
          onChanged: (String val) => _onChange(
                txtCtlr: textEditingController,
                focusNodeInFocus: focusNode,
                index: elementIndex,
                context: context,
              ),
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
            elementIndex: index,
            focusNode: _focusNodes.elementAt(index),
            textEditingController: _txtCtlrs.elementAt(index),
          ));

  @override
  Widget build(BuildContext context) {
    List<Widget> _rows = <Widget>[
      // title
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: widget.titleText,
            ),
          )
        ],
      ),
      // input
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: _buildRowChildren(context),
      ),
      // reset btn
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          OutlineButton(
            padding: EdgeInsets.all(2.0),
            child: Text(
              'RESET',
              textScaleFactor: 0.85,
            ),
            onPressed: () => reset(context),
          ),
        ],
      ),
    ];

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _rows,
      ),
    );
  }
}
