import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// ignore: duplicate_import

class User_details extends StatefulWidget {
  @override
  State<User_details> createState() => _User_details();
}

class _User_details extends State<User_details> {
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      GridView.count(
        // primary: true,
        shrinkWrap: true,
        crossAxisCount: MediaQuery.of(context).size.width < 700 ? 1 : 3,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        //padding: const EdgeInsets.all(8.0),
        children: [
          Container(
            //margin: EdgeInsets.all(20),
            color: Color(0xFFfef8f7),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  MaterialCommunityIcons.dots_vertical,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/humanLogo.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Richard Miles",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Web Development",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //margin: EdgeInsets.all(20),
            color: Color(0xFFfef8f7),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  MaterialCommunityIcons.dots_vertical,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/humanLogo.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Richard Miles",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Web Development",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //margin: EdgeInsets.all(20),
            color: Color(0xFFfef8f7),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  MaterialCommunityIcons.dots_vertical,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/humanLogo.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Richard Miles",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Web Development",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //margin: EdgeInsets.all(20),
            color: Color(0xFFfef8f7),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  MaterialCommunityIcons.dots_vertical,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/humanLogo.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Richard Miles",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Web Development",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //margin: EdgeInsets.all(20),
            color: Color(0xFFfef8f7),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  MaterialCommunityIcons.dots_vertical,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/humanLogo.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Richard Miles",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Web Development",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //margin: EdgeInsets.all(20),
            color: Color(0xFFfef8f7),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  MaterialCommunityIcons.dots_vertical,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/humanLogo.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Richard Miles",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Web Development",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
