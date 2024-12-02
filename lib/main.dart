import 'package:flutter/material.dart';
import 'package:notas_com_compartilhamento/database/dbProvider.dart';
import 'package:notas_com_compartilhamento/screens/add_note.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DBProvider>(
            lazy: true,
            create: (context) => DBProvider())
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => HomeScreen(),
          "/AddNote": (context) => AddNote(),
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suas Notas"),
      ),
      body: Consumer<DBProvider>(builder: (BuildContext context, DBProvider value, Widget? child) {
        return FutureBuilder(
          future: value.getNotes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data == Null){
                return Center(
                  child: Text("Nenhuma nota encontrada."),
                );
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data[index]["title"]),
                      subtitle: Text(snapshot.data[index]["body"]),
                    );
                  },
                );
              }
            }
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },),
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


