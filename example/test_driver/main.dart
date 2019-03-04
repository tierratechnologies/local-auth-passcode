import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';

// import 'package:logmate/config/staging.dart' as App;
import '../lib/main.dart' as App;

void main() {
  enableFlutterDriverExtension();
  WidgetsApp.debugAllowBannerOverride = false; // remove debug banner
  App.main();
}