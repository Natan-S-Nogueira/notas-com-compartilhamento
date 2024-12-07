import 'package:flutter/material.dart';
import 'package:notas/create_edit/create_edit_note_page.dart';

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
        "/create-edit-note": (context) => CreateEditNotePage()
      },
    );
  }
}
