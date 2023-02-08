import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import '../../appState.dart';
import '../../constants/style.dart';
import '../../layout/sidebar/sidemenucontroller.dart';
import 'package:http/http.dart' as http;

import 'create_new_user.dart';

class UserPage extends StatefulWidget {
  final AppState appState;
  UserPage({this.appState});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Stream<QuerySnapshot> users;
  final user = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  void initState() {
    // TODO: implement initState
    super.initState();
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(user.currentUser.uid)
        .collection('addUser')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;

          return Column(
            children: [
              Expanded(
                child: MainMethod(context, data),
              ),
            ],
          );
        });
  }
}

Container MainMethod(BuildContext context, QuerySnapshot<Object> data) {
  return Container(
    child: data.docs.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(
                    Feather.user,
                    size: 150,
                    color: lightGrey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No users Found',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const CreateNewUser(),
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Users',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        border: Border.all(width: 1, color: white)),
                    child: DataTable(
                      border: TableBorder.all(
                        width: 1,
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      columns: const <DataColumn>[
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          'Role',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          'Edit',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          'Delete',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                      ],
                      rows: data.docs.map<DataRow>((e) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(SizedBox(
                              
                              child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    e['name'],
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            )),
                            DataCell(Center(
                                child: InkWell(
                                    onTap: () {}, child: Text(e['email'])))),
                            DataCell(Center(
                                child: InkWell(
                                    onTap: () {}, child: Text(e['role'])))),
                            const DataCell(Center(
                                child: Icon(
                              Icons.edit,
                              color: blue,
                            ))),
                            DataCell(Center(
                                child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(""),
                                              content: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      const Center(
                                                        child: Text(
                                                          'Do you want to remove this user',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          '* Once removed, it cannot be recovered.',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .red[300]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                // usually buttons at the bottom of the dialog
                                                Center(
                                                  child: ElevatedButton(
                                                    child: const Text("Delete"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red[500],
                                                    ),
                                                    onPressed: () {
                                                      e.reference.delete();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red[400],
                                    )))),
                          ],
                        );
                      }).toList(),
                    )),

                    
                    const Center(child: CreateNewUser()),
              ],
            ),
          ),
  );
}
