import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(
      MaterialApp(
          home: HomePage()
      )
  );
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
List<Map<String, String>> _usuarios = [
  {"Nome" : "Pedro" , "Data" : "30-09-1996"},
  {"Nome" : "Felipe" , "Data" : "27-08-1996"},
  {"Nome" : "Bruno" , "Data" : "11-12-1996"},];

class _MyAppState extends State<HomePage> {
  String nomeAux;
  String dataNascAux;

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('INF1300 - Exercicio Ponto Extra'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => AddScreen()),);
          },
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: deviceInfo.size.height / 2,
                child: new ListView.builder(
                  itemCount: _usuarios.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.delete, color: Colors.white),
                                Text('Move to trash', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                      ),
                      onDismissed: (direction) {
                        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Usuário Removido"),
                        ));
                        setState(() {
                          _usuarios.removeAt(index);
                        });
                      },
                      child: Container(
                        child: ListTile(
                            title: Text('${_usuarios[index]["Nome"]} ${_usuarios[index]["Data"]}')
                        ),
                      ),
                    );
                },),
                ),
              ),
            ],),
      ),
    );
  }
}

class AddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAddScreenState();
  }
}

class _MyAddScreenState extends State<AddScreen> {
  String nomeAux;
  String dataNascAux = "";
  DateTime currentDate = DateTime.now();


  currentDateAsString() {
    return "${currentDate.day.toString().padLeft(2,'0')}-${currentDate.month.toString().padLeft(2,'0')}-${currentDate.year.toString()}";
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1850),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Adicionar Usuário'),
          ),
        ),
        body: Column(
          children: [
            TextField(
              onChanged: ( nome ) async {
                nomeAux = nome;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                Text(
                  currentDateAsString(),
                  style: TextStyle(fontSize: 22),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ]
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    _usuarios.add({"Nome" : nomeAux, "Data" : currentDateAsString()});
                    Navigator.pop(context);//,MaterialPageRoute(builder: (context) => HomePage()),);
                    },
                  child: Text(
                    'Adicionar',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);//,MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ),
          ],),
      ),
    );
  }
}