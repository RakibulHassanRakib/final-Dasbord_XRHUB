import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:urlnav2/layout/constants/time.dart';
import 'package:urlnav2/layout/sidebar/sidemenucontroller.dart';

import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import 'components/dropped_file.dart';
import 'components/dropzone_widget.dart';

class IssuePopUp extends StatelessWidget {
  IssuePopUp({Key key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  SideMenuController getInstance = Get.find();
  final pid = GetStorage();

  final user = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  DroppedFile droppedFile;

  String _chosenValueStatus;
  String _chosenValueType;
  String _chosenValuePriority;
  String _chosenValueDiscipline;
  String _chosenValueZone;
  String _chosenValuePhase;
  String _chosenValueAssignedTo;
  String _chosenValueVisibility;

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Center(child: Text("Create issue")),
          content: Container(
            width: ResponsiveWidget.isLargeScreen(context)
                ? MediaQuery.of(context).size.width / 3
                : MediaQuery.of(context).size.width / 2,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const [
                      Text(
                        "Title",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(width: 1, color: blue)),
                      ),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 300,
                    // width: 300,
                    child: DropzoneWidget(
                        // onDroppedFile: (file) =>
                        //     setState(() => droppedFile = file

                        //     ),
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Description",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(width: 1, color: blue)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        focusColor: Colors.white,
                        value: _chosenValueStatus,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          'Closed',
                          'In dispute',
                          'In progress',
                          'In review',
                          'Open',
                          'Resolved',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: grey),
                            ),
                          );
                        }).toList(),

                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _chosenValueStatus ?? "Status",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueStatus = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        focusColor: Colors.white,
                        value: _chosenValueType,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          'Clash',
                          'Commissioning',
                          'Health & Safety',
                          'Inspection & Code Compliance',
                          'RFI',
                          'Site Defect',
                          'Site Observation',
                          'Task',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: grey),
                            ),
                          );
                        }).toList(),

                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _chosenValueType ?? "Type",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueType = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        focusColor: Colors.white,
                        value: _chosenValuePriority,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          'Critical',
                          'High',
                          'Medium',
                          'Low',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: grey),
                            ),
                          );
                        }).toList(),

                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _chosenValuePriority ?? "Priority",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValuePriority = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        focusColor: Colors.white,
                        value: _chosenValueDiscipline,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          'Architectural',
                          'Civil',
                          'MEP',
                          'Site Logistic',
                          'Structural',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: grey),
                            ),
                          );
                        }).toList(),

                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _chosenValueDiscipline ?? "Discipline",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueDiscipline = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        focusColor: Colors.white,
                        value: _chosenValueZone,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          '[Not set]',
                          'Basement',
                          'Facade',
                          'Ground Floor',
                          'Level 1',
                          'MEP',
                          'Mezz.',
                          'Roof',
                          'Site',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: grey),
                            ),
                          );
                        }).toList(),

                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _chosenValueZone ?? "Zone",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueZone = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        focusColor: Colors.white,
                        value: _chosenValuePhase,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          '[Not set]',
                          'CD (Construction Documents) Construction',
                          'DD (Design Development)',
                          'Handover',
                          'SD (Schematic Design',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: grey),
                            ),
                          );
                        }).toList(),

                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _chosenValuePhase ?? "Phase",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValuePhase = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        focusColor: Colors.white,
                        value: _chosenValueAssignedTo,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          'Search...',
                          'Construction Manager',
                          'Document Manager',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: grey),
                            ),
                          );
                        }).toList(),

                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _chosenValueAssignedTo ?? "Assigned to",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueAssignedTo = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        focusColor: Colors.white,
                        value: _chosenValueVisibility,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          'All users in the project',
                          'Restricted to assignee and author',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                value,
                                style: const TextStyle(color: grey),
                              ),
                            ),
                          );
                        }).toList(),

                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _chosenValueVisibility ?? "Visibility",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueVisibility = val;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancel"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                maximumSize: const Size(150, 50),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Create"),
              onPressed: () {
                String today = Time().todayDate();
                final List<int> cardBackgroundColor = [
                  0xFFF44030,
                  0xFFFF7000,
                  0xFFFFC207,
                  0xFF7DC758,
                ];

                final List<int> cardPriorityBackgroundColor = [
                  0xFFAA2D23,
                  0xFFcc5200,
                  0xFFBC8808,
                  0xFFc588B3D,
                ];

                int cardChooseBgColor;
                int cardChooseBgColorPriority;

                if (_chosenValuePriority == 'Critical') {
                  cardChooseBgColor = cardBackgroundColor[0];
                  cardChooseBgColorPriority = cardPriorityBackgroundColor[0];
                } else if (_chosenValuePriority == 'High') {
                  cardChooseBgColor = cardBackgroundColor[1];
                  cardChooseBgColorPriority = cardPriorityBackgroundColor[1];
                } else if (_chosenValuePriority == 'Medium') {
                  cardChooseBgColor = cardBackgroundColor[2];
                  cardChooseBgColorPriority = cardPriorityBackgroundColor[2];
                } else if (_chosenValuePriority == 'Low') {
                  cardChooseBgColor = cardBackgroundColor[3];
                  cardChooseBgColorPriority = cardPriorityBackgroundColor[3];
                }

                firebaseFirestore
                    .collection('users')
                    .doc(user.currentUser.uid)
                    .collection('createProject')
                    .doc(pid.read('projectId'))
                    .collection('createIssue')
                    .add({
                  'titleController': titleController.text,
                  'descriptionController': descriptionController.text,
                  'chosenValueStatus': _chosenValueStatus,
                  'chosenValueType': _chosenValueType,
                  'chosenValuePriority': _chosenValuePriority,
                  'chosenValueDiscipline': _chosenValueDiscipline,
                  'chosenValueZone': _chosenValueZone,
                  'chosenValuePhase': _chosenValuePhase,
                  'chosenValueAssignedTo': _chosenValueAssignedTo,
                  'chosenValueVisibility': _chosenValueVisibility,
                  'dateTime': today,
                  'cardChooseBgColor' : cardChooseBgColor,
                  'cardChooseBgColorPriority' : cardChooseBgColorPriority,
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _showDialog(context);
            },
            icon: const Icon(Feather.plus),
            label: const Text("Create Issue"),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
          ),
          // const SizedBox(width: 2),
          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: const Icon(MaterialIcons.arrow_drop_down),
          //   label: const Text(""),
          //   style: ElevatedButton.styleFrom(
          //     foregroundColor: Colors.white,
          //     backgroundColor: blue,
          //   ),
          // ),
        ],
      ),
    );
  }
}
