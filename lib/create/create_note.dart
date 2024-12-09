import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  var title = '';
  var description = '';
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final existingNote = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (existingNote != null) {
      title = existingNote['title'] ?? '';
      description = existingNote['description'] ?? '';
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Nota'),
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
              autocorrect: true,
              controller: titleController,
              maxLength: 100,
              onChanged: (value) {
                title = value;
                setState(() {});
              },
              decoration: InputDecoration(
                  labelText: 'Título', hintText: 'Digite o título da nota'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: null,
              maxLength: 1000,
              onChanged: (value) {
                description = value;
                setState(() {});
              },
              decoration: InputDecoration(
                  labelText: 'Descrição', hintText: 'Digite aqui sua anotação'),
            ),
            SizedBox(
              height: 32,
            ),
            if (title.isNotEmpty && description.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        if (title.length < 2 || description.length < 2) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Título e descrição devem ter no mínimo 2 letras!"),
                          ));
                        } else {
                          Navigator.pop(context, {
                            'title': title,
                            'description': description,
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
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
