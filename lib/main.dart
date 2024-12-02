import 'package:flutter/material.dart';
import 'package:notas_com_compartilhamento/database/dbProvider.dart';
import 'package:notas_com_compartilhamento/screens/add_note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/AddNote": (context) => AddNote(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, dynamic>>> getNotes() async{
    final notes = await DBProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suas Notas"),
      ),
      body: FutureBuilder(
          future: getNotes(),

          builder: (context, noteData) {
            switch(noteData.connectionState){
              case ConnectionState.waiting :
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                // TODO: Handle this case.
              case ConnectionState.active:
                // TODO: Handle this case.
              case ConnectionState.done:
                if(noteData.data == null){
                  return Center(child: Text("Você não possui notas, crie uma."),
                  );
                }
                else{
                  return Padding(padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: noteData.data?.length,
                    itemBuilder: (BuildContext context, int index){
                      String title = noteData.data?[index]['title'];
                      String body = noteData.data?[index]['body'];
                      String creation_date = noteData.data?[index]['creation_date'];
                      int id = noteData.data?[index]['id'];
                      return Card(child: ListTile(
                        title: Text(title),
                        subtitle: Text(body),
                      ),);
                    },
                  ),
                  );
                }
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Navegar para a criação de uma nota
          Navigator.pushNamed(context, "/AddNote");
        },
        child: Icon(Icons.note_add),
      ),
    );
  }

}


