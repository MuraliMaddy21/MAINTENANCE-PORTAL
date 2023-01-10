import 'dart:convert';
import 'package:maintenance_portal/JsonDataGrid.dart';
import 'package:maintenance_portal/workorder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maintenance_portal/notifydata.dart';
import 'package:maintenance_portal/JsonDataGrid2.dart';

class Notify extends StatelessWidget {
  const Notify({super.key});
  static const String _title = 'NOTIFICATION';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
          appBar: AppBar(title: const Text(_title)), body: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  var users;
  var ordernum;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'NOTIFICATION',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Enter-details',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'NOTIFICATION-DATE',
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () async {
                  if (nameController.text.isNotEmpty) {
                    print(nameController.text);
                    var auth = await getdata();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JsonDataGrid2()));
                  } else {
                    Alert(
                            context: context,
                            title: 'One or many fields is empty',
                            desc: 'Please fill all the necessary details')
                        .show();
                  }
                },
              )),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                child: const Text('WORK-ORDER'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Workorder()));
                },
              )),
        ]));
  }

  getdata() async {
    print("Working fine");

    const url = 'http://localhost:3030/mpnotification';

    final uri = Uri.parse(url);

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>
      {
        
        "nodate": "20220627",
        "plantid":"0001",
      
      
      }),
    );

    var body = response.body;

    print(body);

    //final json = jsonDecode(body);

    setState(() {
      var users = body;
    });

    return users;
  }
}
