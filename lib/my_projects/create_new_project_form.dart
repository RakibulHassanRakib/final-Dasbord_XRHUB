import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';
import '../../constants/style.dart';
import '../layout/constants/time.dart';

class CreateFormButton extends StatefulWidget {
  CreateFormButton({Key key}) : super(key: key);

  @override
  State<CreateFormButton> createState() => _CreateFormButtonState();
}

class _CreateFormButtonState extends State<CreateFormButton> {
  final TextEditingController projectName = TextEditingController();
  final TextEditingController projectNumber = TextEditingController();
  final TextEditingController locationTracker = TextEditingController();
  final TextEditingController projectValue = TextEditingController();

  final user = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  var uuid = const Uuid();

  String _chosenValueT;
  String _chosenValueA;
  String _chosenValueAT;
  String _chosenValueTime;
  String _chosenValueCurrency;
  var startDate;
  var endDate;

  uploadIMage() {
    XFile image;
    ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      setState(() {
        image = value;
      });
    });
    FirebaseStorage.instance
        .ref("desiredPathForImage/")
        .putFile(File(image.path))
        .then((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.success) {
        print("Image uploaded Successful");
        // Get Image URL Now
        taskSnapshot.ref.getDownloadURL().then((imageURL) {
          print("Image Download URL is $imageURL");
        });
      } else if (taskSnapshot.state == TaskState.running) {
        // Show Prgress indicator
      } else if (taskSnapshot.state == TaskState.error) {
        // Handle Error Here
      }
    });
  }

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Center(child: Text("Create Project")),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const [
                      Text(
                        "Project Name",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  TextField(
                    // onSubmitted: ((value) => projectNameController.clear()),
                    controller: projectName,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Enter a project name',
                      labelStyle: TextStyle(
                          color: grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(width: 1, color: blue)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Project Number",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  TextField(
                    controller: projectNumber,
                    decoration: const InputDecoration(
                      labelText: 'Enter a project number',
                      labelStyle: TextStyle(
                          color: grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(width: 1, color: blue)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Account",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
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
                        value: _chosenValueA,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          '   Account 1',
                          '   Account 2',
                          '   Account 3',
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
                            _chosenValueA ?? "Select an account",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueA = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Account Type",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
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
                        value: _chosenValueAT,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          '   Account 1',
                          '   Account 2',
                          '   Account 3',
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
                            _chosenValueAT ?? "Select an account first",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueAT = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Template",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
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
                        value: _chosenValueT,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          '   Template 1',
                          '   Template 2',
                          '   Template 3',
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
                            _chosenValueT ?? "Select an account",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueT = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Address",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Enter address manually',
                          style: TextStyle(
                            color: blue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: locationTracker,
                    decoration: const InputDecoration(
                      labelText: 'Enter a location',
                      labelStyle: TextStyle(
                          color: grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(width: 1, color: blue)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Time Zone",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        MaterialIcons.error_outline,
                        size: 14,
                        color: grey,
                      ),
                    ],
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
                        value: _chosenValueTime,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          '   (GTM + 08:00) Kuala Lumpur',
                          '   (GTM + 09:00) Singapore',
                          '   (GTM + 10:00) Dubai',
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
                            _chosenValueTime ?? "Select an account",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueTime = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Start date",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  MaterialIcons.error_outline,
                                  size: 14,
                                  color: grey,
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DateTimePicker(
                                // decoration: const InputDecoration(
                                //   border: InputBorder.none,
                                // ),
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(MaterialIcons.date_range),
                                ),
                                cursorColor: blue,
                                initialValue: '',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Select Date',
                                onChanged: (val) => startDate = val,
                                validator: (val) {
                                  startDate = val;
                                  return null;
                                },
                                onSaved: (val) => startDate = val,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "End date",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  MaterialIcons.error_outline,
                                  size: 14,
                                  color: grey,
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DateTimePicker(
                                // decoration: const InputDecoration(
                                //   border: InputBorder.none,
                                // ),
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(MaterialIcons.date_range),
                                ),
                                cursorColor: blue,
                                initialValue: '',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Select Date',
                                onChanged: (val) => endDate = val,
                                validator: (val) {
                                  endDate = val;
                                  return null;
                                },
                                onSaved: (val) => endDate = val,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Project value",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            TextField(
                              // onSubmitted: ((value) => projectNameController.clear()),
                              controller: projectValue,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: (BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 155, 154, 154))),
                                ),
                                labelText: 'Enter a value',
                                labelStyle: TextStyle(
                                    color: grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      (BorderSide(width: 1, color: blue)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            StatefulBuilder(builder: (BuildContext context,
                                StateSetter dropDownState) {
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
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  focusColor: Colors.white,
                                  value: _chosenValueCurrency,
                                  //elevation: 5,
                                  style: const TextStyle(color: Colors.white),
                                  iconEnabledColor: grey,
                                  items: <String>[
                                    '   USD',
                                    '   EURO',
                                    '   MYR',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(color: grey),
                                      ),
                                    );
                                  }).toList(),

                                  hint: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      _chosenValueCurrency ?? "CURRENCY",
                                      style: const TextStyle(
                                          color: grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  onChanged: (String val) {
                                    dropDownState(() {
                                      _chosenValueCurrency = val;
                                    });
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                var id = uuid.v1();
                String today = Time().todayDate();
                firebaseFirestore
                    .collection('users')
                    .doc(user.currentUser.uid)
                    .collection('createProject')
                    .doc(id)
                    .set({
                  'projectId': id,
                  'projectName': projectName.text,
                  'projectNumber': projectNumber.text,
                  'locationTracker': locationTracker.text,
                  'projectValue': projectValue.text,
                  'chosenValueT': _chosenValueT,
                  'chosenValueA': _chosenValueA,
                  'chosenValueAT': _chosenValueAT,
                  'chosenValueTime': _chosenValueTime,
                  'chosenValueCurrency': _chosenValueCurrency,
                  'createdDate' : today,
                  'startDate': startDate,
                  'endDate': endDate,
                });
                Navigator.of(context).pop();
                projectName.clear();
                projectNumber.clear();
                locationTracker.clear();
                projectValue.clear();
                startDate.clear();
                endDate.clear();
         
                
              },
            ),
          ],
        );
      },
    );
  }

  List<String> listitems = [
    "Tokyo",
    "London",
    "New York",
    "Sanghai",
    "Moscow",
    "Hong Kong"
  ];
  String selectval = "Tokyo";

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 50) // put the width and height you want
          ),
      onPressed: () {
        _showDialog(context);
        //instance.changeActiveItemTo("Dashboard");
        // widget.appState.selectedIndex = 1;
        //print(instance.activeItem);
      },
      child: const Text('Create new propject'),
    );
  }
}
