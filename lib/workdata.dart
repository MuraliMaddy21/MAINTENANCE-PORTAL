import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:maintenance_portal/main.dart';
import 'dart:convert';
import 'package:maintenance_portal/workdata.dart';
import 'package:maintenance_portal/dart.dart';

class Workless extends StatelessWidget {
  const Workless({super.key});

  @override
  Widget build(BuildContext context) {
    // main();
    return Container();
  }
}

class Workdata extends StatefulWidget {
  const Workdata({super.key});

  @override
  State<Workdata> createState() => _Workdata();
}

class _Workdata extends State<Workdata> {
  var _users,body;
  List <Data> listd=<Data>[]; 


  getdata() async {
    // print("Working fine");
    const url = 'http://localhost:3030/mpworkorder';
    // final uri = Uri.parse(url);
    final response = await http.post(

      Uri.parse(url),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      body: jsonEncode(<String, String>{
        
          "plan":"010",
          "grp":"0001"

        // "username": nameController.text,
        // "password": passwordController.text
      }),
      );
    var b1 = response.body;
    
    var j = json.decode(b1);
    final j2=j['Envelope']['Body']['ZFM_WORKORDER_MP_MD.Response']['WO_LIST']['item'];
    var temp = <Data>[];
    for(var ord in j2){
      temp.add(Data.get(ord));
    }
    print(temp);
    return temp;

  }
   
  @override
  Widget build(BuildContext context) {
   getdata().then((value){
    setState((){
      listd.addAll(value);
    });
  });
  return Scaffold(
    body:ListView.builder(itemBuilder: (context, index){
      return Card(
        child: Column(children: [
          Text(
            "Order ID:  "+listd[index].orderid
          ),
           Text(
            "Date:  "+listd[index].date
          ),
          Text(
            "Activity:  "+listd[index].activity
          ),
          Text(
            "Work Center:  "+listd[index].work_center
          ),
          Text(
            "Plant:  "+listd[index].plant
          ),
          Text(
            "Description:  "+listd[index].description
          ),
          Text(
            "Confirmation Number:  "+listd[index].confirmation_no
          ),
          Text(
            "Schedule Start Date:  "+listd[index].start_date
          ),
          
          Text(
            "Schedule End Date:  "+listd[index].end_date
          ),
         
        ]),
      );

    },itemCount: listd.length,),
    );
}
}