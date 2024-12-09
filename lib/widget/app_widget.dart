import 'package:flutter/material.dart';
import 'package:notas/create/create_note.dart';

import 'package:notas/homepage/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      title: "Notas",
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
        "/create-note": (context) => CreateNote()
      },
    );
  }
}
