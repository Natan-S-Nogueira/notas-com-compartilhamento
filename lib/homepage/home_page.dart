import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notes = <Map<String, String>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notas"),
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
        shadowColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < notes.length; i++)
                Card(
                  child: ListTile(
                    title: Text(notes[i]['title'] ?? "Sem Título"),
                    subtitle: Text(
                      notes[i]['description'] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          notes.removeAt(i);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Nota removida com sucesso!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                    onTap: () async {
                      var response = await Navigator.pushNamed(
                        context,
                        "/create-note",
                        arguments: notes[i],
                      );
                      if (response != null) {
                        setState(() {
                          notes[i] = response as Map<String, String>;
                        });
                      }
                    },
                  ),
                  shadowColor: Colors.amberAccent,
                ),
              OutlinedButton(
                onPressed: () async {
                  var note = await Navigator.pushNamed(context, "/create-note");
                  if (note != null) {
                    setState(() {
                      notes.add(note as Map<String, String>);
                    });
                  }
                },
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(
                        'Criar Nota',
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
