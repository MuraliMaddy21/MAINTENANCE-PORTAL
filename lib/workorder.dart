import 'dart:convert';
import 'package:maintenance_portal/JsonDataGrid.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_portal/notify.dart';
import 'package:http/http.dart' as http;
import 'package:maintenance_portal/dart.dart';
import 'package:maintenance_portal/workdata.dart';

class Workorder extends StatelessWidget {
  const Workorder({super.key});
  static const String _title = 'WORK-ORDER';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
          
          appBar: AppBar(titleTextStyle:TextStyle(color: Colors.white),title: const Text(_title),backgroundColor: Color.fromARGB(255, 107, 13, 4),), 
          body: const MyHomePage()),
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
  TextEditingController passwordController = TextEditingController();

  var body;
  var users;
  var auth;
  var temp;
  List<Data> listd = <Data>[];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Work-Order',
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
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PLANNING-PLANT',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: passwordController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PLANNER GROUP',
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) 
                    {
                      print(nameController.text);
                      print(passwordController.text);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JsonDataGrid()));

                    } 
                    else {
                      Alert(
                              context: context,
                              title: 'One or many fields is empty',
                              desc: 'Please fill all the necessary details')
                          .show();
                    }
                  })),
                Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                  child: const Text('NOTIFICATION'),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Notify()));
                  })),
        ]));
  }

  getdata() async {
    print("Working fine");

    const url = 'http://localhost:3030/mpworkorder';

    final uri = Uri.parse(url);

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "plantid": nameController.text,
        "plangrp": passwordController.text
      }),
    );

    body = response.body;

    final json = jsonDecode(body);

    print(body);

    setState(() {
      users = json;
    });

    return users;
  }
}
