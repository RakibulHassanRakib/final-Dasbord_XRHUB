import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/layout/constants/constants.dart';
import 'package:urlnav2/pages/clients/widgets/clientmain2.dart';

class FilePageMain extends StatelessWidget {
   FilePageMain({Key key}) : super(key: key);

Future<List<NameData>> generateList() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var list = await json.decode(response.body).cast<Map<String, dynamic>>();
    return await list.map<NameData>((json) => NameData.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
            child: FutureBuilder<List<NameData>>(
          future: generateList(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return DataTable(
                border: TableBorder.all(
                  width: 2,
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
                columns: <DataColumn>[
                  const DataColumn(
                    
                    label: Text(
                      'Projects',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Date Created',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Edit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Delete',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: snapShot.data.map<DataRow>((e) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text('${e.id}')),
                      DataCell(Text('${e.userId}')),
                      const DataCell(Icon(Icons.edit)),
                      const DataCell(Icon(Icons.delete)),
                    ],
                  );
                }).toList(),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }
}

class NameData extends ChangeNotifier {
  final int id;
  final int userId;
  final String title;
  final String body;

  NameData({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  factory NameData.fromJson(Map<String, dynamic> json) {
    return NameData(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"],
    );
  }
}
