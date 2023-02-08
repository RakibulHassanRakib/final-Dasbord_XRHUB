import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urlnav2/constants/style.dart';
import 'create_issue_popup.dart';
import 'issue_details.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({Key key}) : super(key: key);

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  int rand = Random().nextInt(7);
  Stream<QuerySnapshot> users;
  final user = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final pid = GetStorage();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(user.currentUser.uid)
        .collection('createProject')
        .doc(pid.read('projectId'))
        .collection('createIssue')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
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
          }),
    );
  }

  Container MainMethod(BuildContext context, QuerySnapshot<Object> data) {
    return Container(
      child: MediaQuery.of(context).size.width > 735
          ? Container(
              color: white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IssuePopUp(),

                            // hjadfgjdhjfhsgh
                            ///hjgfgsdhfg
                            ///hjdgfgsdhf
                            SizedBox(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Feather.plus),
                                  label: const Text("Export All"),
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(
                                          255, 166, 167, 168),
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12)),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(AntDesign.search1),
                                  label:
                                      const Text("Search by issue title or id"),
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(
                                          255, 166, 167, 168),
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12)),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(AntDesign.filter),
                                  label: const Text(""),
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(
                                          255, 166, 167, 168),
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12)),
                                ),
                              ],
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        data.docs.isEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                    Image.asset(
                                      'assets/images/folder.png',
                                      height: 200,
                                      width: 200,
                                    ),
                                    const Center(
                                      child: Text(
                                        "There are no issues on this project",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Center(
                                      child: Text(
                                          "All issues created for this project will appear here.Create new issues from this page or directly from a sheet or model"),
                                    ),
                                  ])
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount: data.size,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).size.width > 900
                                          ? 2
                                          : 1,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: (2.5 / 1),
                                ),
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  

                                  print(data.docs[index]
                                          ['chosenValuePriority'] ==
                                      'Low');
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IssueDetails(
                                                    data: data.docs[index]
                                                  )));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(data.docs[index]['cardChooseBgColor']),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Image.network(
                                                  'https://picsum.photos/200/300',
                                                  fit: BoxFit.cover,
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            data.docs[index][
                                                                'titleController'],
                                                            style: const TextStyle(
                                                                color: white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Color(data.docs[index]['cardChooseBgColorPriority']),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16)),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 5),
                                                              child: Text(
                                                                data.docs[index]
                                                                    [
                                                                    'chosenValueStatus'],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10,
                                                                    letterSpacing:
                                                                        0.5),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),

                                                      //
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'Created',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                data.docs[index]
                                                                    [
                                                                    'dateTime'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          76,
                                                                          76,
                                                                          77),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'Type',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                data.docs[index]
                                                                    [
                                                                    'chosenValueType'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          76,
                                                                          76,
                                                                          77 ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),

                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                           Column(
                                                             children: [
                                                               Text(
                                                                  'Assign to',style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),),
                                                                  Text(data.docs[index]['chosenValueAssignedTo']),
                                                             ],
                                                           ),
                                                          ElevatedButton.icon(
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title:
                                                                        const Center(
                                                                      child: Text(
                                                                          "Confirm Delete"),
                                                                    ),
                                                                    content:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          4,
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
                                                                            const Center(child: Text('Are you sure you want to delete this issue?')),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            const Center(
                                                                                child: Text(
                                                                              '* Once deleted, it cannot be recovered!!!',
                                                                              style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
                                                                            )),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      ElevatedButton(
                                                                        child: const Text(
                                                                            "Cancel"),
                                                                        style: ElevatedButton.styleFrom(
                                                                            //backgroundColor: Colors.white,

                                                                            ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                      // usually buttons at the bottom of the dialog
                                                                      ElevatedButton(
                                                                        child: const Text(
                                                                            "Delete"),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.red[500],
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          data.docs[index]
                                                                              .reference
                                                                              .delete();
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            label: const Text(
                                                                'Delete'),
                                                            icon: const Icon(
                                                                Icons.delete,
                                                                size: 18),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors.red[
                                                                            500]),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ]),
                ),
              ))
          : Center(
              child: Container(
                  child: Column(
              children: [
                const Icon(
                  MaterialIcons.laptop,
                  size: 100,
                  color: lightGrey,
                ),
                const Text('Use Laptop to view the content'),
              ],
            ))),
    );
  }
}
