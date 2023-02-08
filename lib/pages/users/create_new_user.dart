import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';
import '../../constants/style.dart';
import '../../helpers/helperfunctions.dart';
import '../../helpers/services/auth.dart';
import '../../layout/sidebar/sidemenucontroller.dart';

class CreateNewUser extends StatefulWidget {
  const CreateNewUser({Key key}) : super(key: key);

  @override
  State<CreateNewUser> createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  final TextEditingController nameController = TextEditingController();


  final TextEditingController emailController = TextEditingController();

  final TextEditingController roleController = TextEditingController();

  final TextEditingController departmentController = TextEditingController();

  final TextEditingController licenceKeyController = TextEditingController();

  String _chosenValueDept;

  final user = FirebaseAuth.instance;

  final firebaseFirestore = FirebaseFirestore.instance;
  var uuid = const Uuid();
  SideMenuController getinstance = Get.find();
  AuthService authService =  AuthService();

 

  

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title:  Center(child: Image.asset(
                "assets/images/logo.png",
              width: 200,
              ),),
          content: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
              const SizedBox(height: 26,),
              const Text('Create new User', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),),
              const Text('Get access to Project', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              const SizedBox(height: 26,),
                  Row(
                    children: const [
                      Text(
                        "Full Name",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: blue)),
                      ),
                      
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Email",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: blue)),
                      ),
                      
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: const [
                      Text(
                        "Role",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  TextField(
                    controller: roleController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: blue)),
                      ),
                      
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Department",
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
                        value: _chosenValueDept,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: grey,
                        items: <String>[
                          '   Finance',
                          '   Development',
                          '   Marketing',
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
                            _chosenValueDept ?? "Select an Department",
                            style: const TextStyle(
                                color: grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onChanged: (String val) {
                          dropDownState(() {
                            _chosenValueDept = val;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 10,),
                  Row(
                    children: const [
                      Text(
                        "Licence Key",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  TextField(
                    controller: licenceKeyController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: blue)),
                      ),
                      
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  
                ],
              ),
            ),
          ),
          actions: <Widget>[
          
            // usually buttons at the bottom of the dialog
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  
                  // style: ElevatedButton.styleFrom(
                  //   fixedSize: Size(1, 50)
                  // ),
                  child: const Text("Create"),
                  onPressed: () async {

                    
                     final value = GetStorage();
                     final thisProjectId = value.read('projectId');
                    // var id = uuid.v1();

                    await authService
          .signUpWithEmailAndPassword(
              emailController.text, 'passwordController')
          .then((result) async {
        if (result != null) {
          User user = FirebaseAuth.instance.currentUser;

          


          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserIDSharedPreference(user.uid);
          HelperFunctions.saveUserNameSharedPreference(nameController.text);
          HelperFunctions.saveUserEmailSharedPreference(emailController.text);

          
        }
      });

      firebaseFirestore
                        .collection('users')
                        .doc(user.currentUser.uid)
                        .collection('addUser').doc()
                        .set({
                          'projectId' : thisProjectId,
                      'name': nameController.text,
                      'email': emailController.text,
                      'role': roleController.text,
                      'licenceKey': licenceKeyController.text,
                      
                    });
                    
                    
                    nameController.clear();
                    emailController.clear();
                    roleController.clear();
                    licenceKeyController.clear();
                    Navigator.of(context).pop();

                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
      child: const Text('Create new User'),
    );
  }
}
