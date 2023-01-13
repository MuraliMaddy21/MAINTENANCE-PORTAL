import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MyApp());
}

/// The application that contains datagrid on it.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Syncfusion DataGrid Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      home: JsonDataGrid2(),
    );
  }
}

class JsonDataGrid2 extends StatefulWidget {
  @override
  _JsonDataGridState2 createState() => _JsonDataGridState2();
}

class _JsonDataGridState2 extends State<JsonDataGrid2> {
  late _JsonDataGridSource jsonDataGridSource;
  List<_Product> productlist = [];

  Future generateProductList() async {
    var response =
        await http.get(Uri.parse("http://localhost:3030/mpnotification"));
    print(response.body.runtimeType);
    // print(response.body);

    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    print("json ==============>");
    print(list.runtimeType);
    print(list);

    productlist =
        list.map<_Product>((dynamic json) => _Product.fromJson(json)).toList();

    // print("list ==============>");
    // print(productlist.runtimeType);

    jsonDataGridSource = _JsonDataGridSource(productlist);
    return productlist;
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = ([
      GridColumn(
        columnName: 'NOTICE ID',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'NOTICE ID',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: '   EQUIP DESCRIPTION    ',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'EQUIPMENT DESCRIPTION',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'START DATE',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'START DATE',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'NOTICE TIME',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'NOTICE TIME',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'NOTICE DATE',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'NOTICE DATE',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'DESCRIPTION',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            ' DESCRIPTION',
            // overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'SYSTEM_STATUS',
        width: 130,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'SYSTEM_STATUS',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'PRIORITY',
        width: 120,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'PRIORITY',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
    ]);
    return columns;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICATION'),
      ),
      body: Container(
          child: FutureBuilder(
              future: generateProductList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.hasData
                    ? SfDataGrid(
                        source: jsonDataGridSource, columns: getColumns())
                    : Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      );
              })),
    );
  }
}

class _Product {
  factory _Product.fromJson(Map<String, dynamic> json) {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return _Product(
      noticeid:
          json['NOTIFICAT'].toString().replaceAll(new RegExp(r"^0+(?!$)"), ""),
      notice_type: json['NOTIF_TYPE'],
      equip: json['EQUIPMENT'],
      equip_description: json['EQUIDESCR'],
      description: json['DESCRIPT'],
      loc_description: json['S_STATUS'],
      notice_time: json['NOTIFTIME'],
      notice_date: formatter.format(DateTime.parse(json['NOTIFDATE'])),
      start_date: formatter.format(DateTime.parse(json['STARTDATE'])),
      priority: json['PRIOTYPE'],
      ext_num: json['EXTERNAL_NUMBER'],
    );
  }

  _Product({
    this.noticeid,
    this.notice_type,
    this.equip,
    this.equip_description,
    this.description,
    this.loc_description,
    this.notice_date,
    this.notice_time,
    this.priority,
    this.ext_num,
    this.start_date
  });
  String? noticeid;
  String? notice_type;
  String? equip;
  String? equip_description;
  String? loc_description;
  String? description;
  String? notice_date;
  String? notice_time;
  String? priority;
  String? ext_num;
  String? start_date;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'NOTICE ID': noticeid,
        'NOTICE TYPE': notice_type,
        'EQUIP': equip,
        'START DATE': start_date,
        'DESCRIPTION': equip_description,
        'PRIORITY': priority,
        'LOC DESCRIPTION': loc_description,
        'NOTICE DATE': notice_date,
        'NOTICE TIME': notice_time,
        'EXTERNAL_NUM': ext_num,
        'DESCRIPTION': description,
      };
}

class _JsonDataGridSource extends DataGridSource {
  _JsonDataGridSource(this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<_Product> productlist = [];

  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'NOTICE ID', value: dataGridRow.noticeid),
        DataGridCell<String>(
            columnName: 'EQUIP DESCRIPTION',
            value: dataGridRow.equip_description),
        DataGridCell<String>(
            columnName: 'START DATE', value: dataGridRow.start_date),
        DataGridCell<String>(
            columnName: 'NOTICE TIME', value: dataGridRow.notice_time),
        DataGridCell<String>(
            columnName: 'NOTICE DATE', value: dataGridRow.notice_date),
        DataGridCell<String>(
            columnName: 'DESCRIPTION', value: dataGridRow.description),
        DataGridCell<String>(
            columnName: 'SYSTEM_STATUS', value: dataGridRow.ext_num),
        DataGridCell<String>(
            columnName: 'PRIORITY', value: dataGridRow.priority),
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.visible,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[6].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[7].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }
}
