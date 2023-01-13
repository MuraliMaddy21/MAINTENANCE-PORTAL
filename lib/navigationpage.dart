import 'package:flutter/material.dart';
import 'package:maintenance_portal/notify.dart';
import 'package:maintenance_portal/workorder.dart';

class LoginSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DASHBOARD'),
          backgroundColor: Color.fromARGB(255, 107, 13, 4),
          centerTitle: true,
        ), //AppBar
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.greenAccent[100],
                child: SizedBox(
                  width: 300,
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 64, 6, 2),
                          radius: 100,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://media.sketchfab.com/models/4629e364879a444db7a724fe1d896d9d/thumbnails/a4d9ba0a554842e598b6a061a88a225d/95d0da08c321436593a391369f039ad5.jpeg"),
                            radius: 100,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'WORK-ORDER',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'A work order in SAP is a document used to record and track the production or maintenance of a specific product or service. It contains details such as the material or service to be produced or maintained',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Workorder()));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [Icon(Icons.touch_app), Text('View')],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              //SECOND child
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.greenAccent[100],
                child: SizedBox(
                  width: 300,
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 64, 6, 2),
                          radius: 100,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://media.sketchfab.com/models/4629e364879a444db7a724fe1d896d9d/thumbnails/a4d9ba0a554842e598b6a061a88a225d/95d0da08c321436593a391369f039ad5.jpeg"),
                            radius: 100,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'NOTIFICATION',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'In SAP Plant Maintenance (PM), notifications are used to manage and track maintenance and repair work orders. A notification is a request for maintenance or repair work and can be created manually or automatically based on predefined conditions',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Notify()));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [Icon(Icons.touch_app), Text('View')],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        );
  }
}
