import 'package:flutter/material.dart';
import 'package:notas_com_compartilhamento/database/dbProvider.dart';
import 'package:notas_com_compartilhamento/models/noteModel.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String body;
  late DateTime date;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addNote(NoteModel note){
    DBProvider.db.addNewNote(note);
    print("Nota adicionada com sucesso.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicione uma nova Nota"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Título",
            ),
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Sua nota",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            date = DateTime.now();
          });
          NoteModel note =
            NoteModel(title: title, body:body, creation_date: date);
          addNote(note);
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        label: Text("Salvar Nota"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
