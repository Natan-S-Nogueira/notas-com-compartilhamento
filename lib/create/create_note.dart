import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (note != null) {
      titleController.text = note['title'] ?? "";
      descriptionController.text = note['description'] ?? "";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Criar Nota' : 'Editar Nota'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue, Colors.lightBlue],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              autofocus: true,
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                hintText: 'Digite o título da sua anotação',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: null,
              maxLength: 1000,
              decoration: InputDecoration(
                labelText: 'Descrição',
                hintText: 'Digite o conteúdo da sua anotação',
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("O título e a descrição não podem estar vazios!"),
                    ),
                  );
                } else {
                  Navigator.pop(context, {
                    'title': titleController.text,
                    'description': descriptionController.text,
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.save, size: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Salvar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
