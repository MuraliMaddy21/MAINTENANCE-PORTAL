import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:maintenance_portal/navigationpage.dart';
import 'package:maintenance_portal/workorder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'MAINTENANCE PORTAL';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
          appBar: AppBar(title: const Text(_title),
          backgroundColor: Color.fromARGB(255, 107, 13, 4),
          ), body: const MyHomePage()),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'KAAR TECHNOLOGIES',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
               Container(
    child: Image(
      image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/SAP_2011_logo.svg/1200px-SAP_2011_logo.svg.png'),
      width: 20,
      height: 100,
      alignment: Alignment.center,
    ),
  ),
 Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'LOGIN',
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
                labelText: 'USER-ID',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'PASSWORD'),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  if (nameController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    print(nameController.text);
                    print(passwordController.text);
                    auth = await getdata();

                    print(auth);
                  } else {
                    Alert(
                            context: context,
                            title: 'One or many fields is empty',
                            desc:'Please fill all the necessary details')
                        .show();
                  }

                  if (auth['Envelope']['Body']['ZFM_LOGIN_MP_MD.Response']
                          ['E_FLAG'] ==
                      '1') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginSuccessScreen()));
                  } else {
                    Alert(
                            context: context,
                            title: 'Incorrect Password',
                            desc:'Recheck Credentials')
                        .show();
                  }
                },
              )),
        ]));
  }

  getdata() async {
    print("Working fine");

    const url = 'http://localhost:3030/mplogin';

    final uri = Uri.parse(url);

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "mainid": nameController.text,
        "password": passwordController.text
      }),
    );

    body = response.body;

    print(body);

    final json = jsonDecode(body);

    setState(() {
      users = json;
    });
    return users;
  }
}

