import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/layout/sidebar/sidemenucontroller.dart';

class TopNav extends StatefulWidget {
  const TopNav({Key key}) : super(key: key);

  @override
  State<TopNav> createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
  Stream<QuerySnapshot> users;
  final user = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  var checkOpenOrDelete = 0;
  SideMenuController getInstance = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(user.currentUser.uid)
        .collection('createProject')
        .snapshots();
  }

  String dropdownValue = 'One';
  List<String> projectList = [];

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
              Visibility(child: ListView.builder(
                    itemCount: data.docs.length,
                    shrinkWrap: true,
                    // padding: EdgeInsets.symmetric(vertical: 10),

                    itemBuilder: ((context, index) {
                     
                       projectList.add(data.docs[index]['titleController']);
                    })),
              
              
              visible: false,),
              DropdownButton<String>(
                
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: projectList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          );
        });
  }
}

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      toolbarHeight: toolbarheight,
      shape:
          Border.symmetric(horizontal: BorderSide(color: lightGrey, width: .5)),
      leading: ResponsiveWidget.isLargeScreen(context)
          ? SizedBox(
          height: 0,
          width: 0,
            )
          : IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                key.currentState.openDrawer();
              }),
      title: Container(
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ResponsiveWidget.isLargeScreen(context) ?

            Container(
              child: TextButton.icon(
                onPressed: () {},
                label: TopNav(),
                icon: Icon(Icons.arrow_back),
              ),
            ),
            //: Text(''),
            Expanded(child: Container()),

            //  ResponsiveWidget.isLargeScreen(context) ? Row(
            //     children: [
            //       ElevatedButton(onPressed: (){}, child: Text('View buying option'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(blue)),),
            //       IconButton(
            //       icon: Icon(
            //         AntDesign.questioncircle,
            //         color: dark.withOpacity(.7),
            //       ),
            //       onPressed: () {}),
            //       Container(
            //     width: 1,
            //     height: 22,
            //     color: lightGrey,
            //   ),
            //     ],
            //   ) : Text(''),

            /*IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: dark.withOpacity(.7),
                ),
                onPressed: () {
                  showPopover(
                      context: context,
                      transitionDuration: const Duration(milliseconds: 150),
                      bodyBuilder: (context) => const ListItems(),
                      onPop: () {},
                      direction: PopoverDirection.top,
                      width: 200,
                      height: 400,
                      arrowHeight: 15,
                      arrowWidth: 30);
                }),*/
            //SettingsIcons(icon: Icons.settings_outlined),
            //SettingsIcons(icon: Icons.notifications_outlined),

            const SizedBox(
              width: 24,
            ),
            //Getusername(),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () async {
                
                await FirebaseAuth.instance.signOut();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: active.withOpacity(.5),
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  decoration: BoxDecoration(
                      color: legistwhite,
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(2),
                  child: const CircleAvatar(
                    backgroundColor: legistwhite,
                    child: Icon(
                      Icons.person_outline,
                      color: dark,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Teczo Unity',
              style: TextStyle(
                color: dark,
                fontSize: 15,
              ),
            ),
            SizedBox(
              width: 5,
            ),

            Icon(
              AntDesign.caretdown,
              size: 15,
            ),
          ],
        ),
      ),
      iconTheme: const IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: legistwhite,
    );
