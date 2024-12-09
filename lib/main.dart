import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notas/widget/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(AppWidget());
}

