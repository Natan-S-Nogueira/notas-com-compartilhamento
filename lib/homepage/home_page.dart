import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notes = <String>[];

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
                    title: Text(notes[i]),
                    onTap: () async {
                      var response = await Navigator.pushNamed(
                          context, "/create-edit-note",
                          arguments: notes[i]);
                      if (response != null) {
                        var descripton = response as String;
                        if (response.isEmpty) {
                          notes.removeAt(i);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Nota Excluída"),
                          ));
                        } else {
                          notes[i] = descripton;
                        }
                      }
                      setState(() {});
                    },
                  ),
                  shadowColor: Colors.amberAccent,
                ),
              OutlinedButton(
                  onPressed: () async {
                    var description =
                        await Navigator.pushNamed(context, "/create-edit-note");
                    if (description != null) {
                      notes.add(description as String);
                      setState(() {});
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
                  ))
            ], // Children
          ),
        ),
      ),
    );
  }
}
