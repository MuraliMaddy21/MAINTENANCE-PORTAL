import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:maintenance_portal/dart1.dart';


class Workless extends StatelessWidget {
  const Workless({super.key});

  @override
  Widget build(BuildContext context) {
    // main();
    return Container();
  }
}

class Notifydata extends StatefulWidget {
  const Notifydata({super.key});

  @override
  State<Notifydata> createState() => _Notifydata();
}

class _Notifydata extends State<Notifydata> {
  var _users, body;
  List<Data> listd = <Data>[];

  getdata() async {
    // print("Working fine");
    const url = 'http://localhost:3030/mpnotification';
    // final uri = Uri.parse(url);
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "plantid": "0001",
        "nodate": "20220627"
      }),
    );
    var b1 = response.body;

    var j = json.decode(b1);

    final j2 = j['Envelope']['Body']['ZFM_NOTIFICATION_MP_MD.Response']['NOTIFICATION_LIST']['item'];

    var temp = <Data>[];


    for (var ord in j2) {
      temp.add(Data.get(ord));
    }
    print(temp);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    getdata().then((value) {
      setState(() {
        listd.addAll(value);
      });
    });
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Column(children: [
              Text("Notice ID:  " + listd[index].noticeid),
              Text("Notice Type:  " + listd[index].notice_type),
              Text("Purchase Date:  " + listd[index].purchase_date),
              Text("Description:  " + listd[index].description),
              Text("LOC Description:  " + listd[index].loc_description),
              Text("Notice Date:  " + listd[index].notice_date),
              Text("Notice Time:  " + listd[index].notice_time),
              Text(" Time Zone:  " + listd[index].timezone),
              Text("Ext Number:  " + listd[index].ext_num)
            ]),
          );
        },
        itemCount: listd.length,
      ),
    );
  }
}
