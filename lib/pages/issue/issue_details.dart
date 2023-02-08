import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../constants/style.dart';

class IssueDetails extends StatelessWidget {
  final QueryDocumentSnapshot<Object> data;


  const IssueDetails({Key key, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Card(
              elevation: 5,
              shadowColor: Colors.black,
              color: Color(data['cardChooseBgColor']),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  //  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 450,
                        child: Image.network(
                          'https://picsum.photos/200/300',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data['descriptionController'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    flex: 5,
                                  ),
                                  const Expanded(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Status',
                            style: TextStyle(
                                color: Colors.white,
                            
                                fontWeight: FontWeight.bold),
                          ),

                          SizedBox(width: MediaQuery.of(context).size.width/7.8,),
                          
                          Container(
                            
                            decoration: BoxDecoration(
                                color:  Color(data['cardChooseBgColorPriority']),
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(
                                data['chosenValueStatus'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Type',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data['chosenValueType'],
                                style:
                                    const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Priority',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data['chosenValuePriority'],
                                style:
                                    const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Discipline',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data['chosenValueDiscipline'],
                                style:
                                    const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Zone',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data['chosenValueZone'],
                                style:
                                    const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Phase',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data['chosenValuePhase'],
                                style:
                                    const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Assign to',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data['chosenValueAssignedTo'],
                                style:
                                    const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Visibility',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data['chosenValueVisibility'],
                                style:
                                    const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Date created',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data['dateTime'],
                                style:
                                    const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          //comment box
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 235, 235, 235),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(4)),
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Comments'),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    // controller: textarea,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: InputDecoration(
                        hintText: "Write a comment...",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: greyBc),
                        )),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),
        ],
      )),
    );
  }
}
