import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/rfis/rfis_form.dart';

class RFIsPage extends StatefulWidget {
  RFIsPage({Key key}) : super(key: key);

  @override
  State<RFIsPage> createState() => _RFIsPageState();
}

class _RFIsPageState extends State<RFIsPage> {
  Stream<QuerySnapshot> users;

  final user = FirebaseAuth.instance;

  final firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(user.currentUser.uid)
        .collection('rfis')
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

Widget MainMethod(BuildContext context, QuerySnapshot<Object> data) {
  return Container(
      color: white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "RFIs",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                AntDesign.menuunfold,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 8,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const Icon(
                FontAwesome.caret_down,
                color: Colors.blue,
                size: 12,
              ),
            ],
          ),
          const Divider(color: Color.fromARGB(255, 195, 196, 197)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: data.docs.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                          const SizedBox(height: 45),
                          Image.asset(
                            'assets/images/rfis.png',
                            height: 200,
                            width: 200,
                          ),
                          const Center(
                            child: Text(
                              "No RFIs to display",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Center(
                            child:
                                Text(''' you don't have any RFIs assigned '''),
                          ),
                          const Center(child: Text("or visible to you yet.")),
                          CreateRFI(),
                        ])
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: data.size,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 3
                            : 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: (2 / 1),
                      ),
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: greyBc,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Icon(items[index].icon),
                                  //Text(items[index].title,style: TextStyle(fontSize: 18, color: Colors.black),
                                  // textAlign: TextAlign.center),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${data.docs[index]['titleController']}',
                                        style: const TextStyle(
                                          color: blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            'Open',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      child: Expanded(
                                        child: Text(
                                            '''${data.docs[index]['descriptionController']}'''),
                                      ),
                                    ),
                                  ),

                                  Expanded(child: Container()),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'View Details',
                                            style: TextStyle(color: blue),
                                          )),
                                      TextButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          ),
                                          label: const Text(
                                            'Solved',
                                            style:
                                                TextStyle(color: Colors.green),
                                          )),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // return object of type Dialog
                                              return AlertDialog(
                                                title: const Text("Confirm Delete"),
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
                                                        const Text(
                                                            'Are you sure you want to delete this issue? Once deleted, it cannot be recovered.'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child: const Text("Cancel"),
                                                    style: ElevatedButton.styleFrom(
                                                        //backgroundColor: Colors.white,

                                                        ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  // usually buttons at the bottom of the dialog
                                                  ElevatedButton(
                                                    child: const Text("Delete"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red[500],
                                                    ),
                                                    onPressed: () {
                                                      data.docs[index].reference
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
                                        label: const Text('Delete'),
                                        icon: const Icon(Icons.delete),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red[500]),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
        ]),
      ));
}
