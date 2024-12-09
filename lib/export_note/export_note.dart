import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ExportNote {
  static Future<void> export(BuildContext context, String title, String content) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$title.txt';

      final file = File(filePath);
      await file.writeAsString(content);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Nota exportada com sucesso!\nLocal: $filePath'),
        duration: Duration(seconds: 4),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao exportar nota: $e'),
        duration: Duration(seconds: 4),
      ));
      print(e);
    }
  }

}
