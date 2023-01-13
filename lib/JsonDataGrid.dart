
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
      home: JsonDataGrid(),
    );
  }
}

class JsonDataGrid extends StatefulWidget {
  @override
  _JsonDataGridState createState() => _JsonDataGridState();
}

class _JsonDataGridState extends State<JsonDataGrid> {
  late _JsonDataGridSource jsonDataGridSource;
  List<_Product> productlist = [];

  Future generateProductList() async {
    var response = await http.get(Uri.parse("http://localhost:3030/mpworkorder"));
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
        columnName: 'ORDER_ID',
        width: 120,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'ORDER_ID',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'ACTIVITY',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'ACTIVITY',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'CONTROL_KEY',
        width: 120,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'CONTROL_KEY',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'WORK_CENTRE',
        width: 120,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'WORK_CENTRE',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'PLANT',
        width: 70,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'PLANT',
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
            'DESCRIPTION',
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
        columnName: 'UNIT_OF_WORK',
        width: 120,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'UNIT_OF_WORK',
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
        title: Text('WORK ORDER'),
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
    return _Product(
      ORDER_ID: json['ORDERID'].toString().replaceAll(new RegExp(r"^0+(?!$)"), ""),
      ACTIVITY: json['ACTIVITY'].toString().replaceAll(new RegExp(r"^0+(?!$)"), ""),
      CONTROL_KEY: json['CONTROL_KEY'],
      WORK_CENTRE: json['WORK_CNTR'],
      PLANT: json['PLANT'].toString().replaceAll(new RegExp(r"^0+(?!$)"), ""),
      DESCRIPTION: json['DESCRIPTION'],
      SYSTEM_STATUS: json['S_STATUS'],
      UNIT_OF_WORK: json['UN_WORK'],
    );
  }

  _Product({
    this.ORDER_ID,
    this.ACTIVITY,
    this.CONTROL_KEY,
    this.WORK_CENTRE,
    this.PLANT,
    this.DESCRIPTION,
    this.SYSTEM_STATUS,
    this.UNIT_OF_WORK,
  });
  String? ORDER_ID;
  String? ACTIVITY;
  String? CONTROL_KEY;
  String? WORK_CENTRE;
  String? PLANT;
  String? DESCRIPTION;
  String? SYSTEM_STATUS;
  String? UNIT_OF_WORK;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ORDER_ID': ORDER_ID,
        'ACTIVITY': ACTIVITY,
        'CONTROL_KEY': CONTROL_KEY,
        'WORK_CENTRE': WORK_CENTRE,
        'PLANT': PLANT,
        'DESCRIPTION': DESCRIPTION,
        'SYSTEM_STATUS': SYSTEM_STATUS,
        'UNIT_OF_WORK': UNIT_OF_WORK,
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
            columnName: 'ORDER_ID', value: dataGridRow.ORDER_ID),
        DataGridCell<String>(
            columnName: 'ACTIVITY', value: dataGridRow.ACTIVITY),
        DataGridCell<String>(
            columnName: 'CONTROL_KEY', value: dataGridRow.CONTROL_KEY),
        DataGridCell<String>(
            columnName: 'WORK_CENTRE', value: dataGridRow.WORK_CENTRE),
        DataGridCell<String>(columnName: 'PLANT', value: dataGridRow.PLANT),
        DataGridCell<String>(
            columnName: 'DESCRIPTION', value: dataGridRow.DESCRIPTION),
        DataGridCell<String>(
            columnName: 'SYSTEM_STATUS', value: dataGridRow.SYSTEM_STATUS),
        DataGridCell<String>(
            columnName: 'UNIT_OF_WORK', value: dataGridRow.UNIT_OF_WORK),
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

