import 'package:flutter/material.dart';
import 'package:notas/widget/app_widget.dart';

import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(AppWidget());
}
