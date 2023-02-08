// ignore_for_file: sized_box_for_whitespace

import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/layout/sidebar/sidemenucontroller.dart';
import 'package:urlnav2/pages/dashboard/project_breackdown.dart';
import 'package:urlnav2/pages/dashboard/widget/dashboard_create_milestone.dart';
import 'package:urlnav2/pages/dashboard/widget/dashboard_user_details.dart';

import 'dashboard_calender.dart';

class DashboardHomePage extends StatefulWidget {
  final AppState appState;
  const DashboardHomePage({this.appState});

  @override
  State<DashboardHomePage> createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  bool isViewingClock = true;
  bool isViewingClients = true;
  bool isViewingCases = false;
  int myclientindex = 0;

  Stream<DocumentSnapshot<Map<String, dynamic>>> users;
  Stream<QuerySnapshot> events;
  Stream<QuerySnapshot> notes;
  Stream<QuerySnapshot> clients;
  Stream<QuerySnapshot> clients2;
  Stream<QuerySnapshot> cases;

  List<_ChartData> data;
  List<SalesData> saleschartData;
  TooltipBehavior _tooltip;

  SideMenuController getInstance = Get.find();

  @override
  void initState() {
    super.initState();
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('createProject')
        .doc(getInstance.projectId.read('projectId'))
        .snapshots();

    // users = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.appState.myid)
    //     .collection('details')
    //     .snapshots();
    // events = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.appState.myid)
    //     .collection('events')
    //     .snapshots();
    // notes = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.appState.myid)
    //     .collection('notes')
    //     .snapshots();
    // clients = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.appState.myid)
    //     .collection('clients')
    //     .snapshots();
    // clients2 = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.appState.myid)
    //     .collection('clients')
    //     .snapshots();
    // cases = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.appState.myid)
    //     .collection('cases')
    //     .snapshots();

    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);

    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    saleschartData = [
      SalesData(DateTime(2010), 35),
      SalesData(DateTime(2011), 28),
      SalesData(DateTime(2012), 34),
      SalesData(DateTime(2013), 32),
      SalesData(DateTime(2014), 40)
    ];

    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  List<GDPData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: users,
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final projectData = snapshot.data;

          return Column(
            children: [
              Expanded(
                child: ResponsiveWidget.isLargeScreen(context)
                    ? method1(context, projectData)
                    : method2(context, projectData),
              ),
            ],
          );
        });
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 1600),
      GDPData('Africa', 2490),
      GDPData('S America', 2900),
    ];
    return chartData;
  }

  Widget method2(BuildContext context, DocumentSnapshot<Object> projectData) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(paddingMax),
        children: [
          bodyContent(projectData),

          const SizedBox(
            height: 20,
          ),
          bodyLeftPart(),
          const SizedBox(
            height: 20,
          ),
          //bodyRightPart(),
        ],
      ),
    );
  }

  Widget method1(BuildContext context, DocumentSnapshot<Object> projectData) {
    return ListView(
      //padding: const EdgeInsets.all(paddingMax),
      children: [
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              bodyContent(projectData),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  bodyLeftPart(),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded bodyRightPart() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Weather(),
          // SizedBox(
          //   height: 20,
          // ),
          Container(
            height: MediaQuery.of(context).size.height / 1.5 + 60,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Activity ',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    height: 1.5,
                    color: Color.fromARGB(255, 224, 224, 224),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('View All'),
                        Icon(
                          MaterialIcons.keyboard_arrow_down,
                          size: 18,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 235, 235, 235),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  const Center(child: Text('No Project Activity to Diaplay')),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 235, 235, 235),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(4)),
          ),
        ],
      ),
      flex: 1,
    );
  }

  Expanded bodyLeftPart() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //code herte
          Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 235, 235, 235),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(4)),
              child: Text('MAp')),

          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // quickLinks(),
              // const SizedBox(
              //   width: 10,
              // ),
              //siteWeather(),
              redialGraph(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              SizedBox(height: 16),
              ListView(shrinkWrap: true, children: [
                GridView.count(
                  primary: true,
                  shrinkWrap: true,
                  crossAxisCount:
                      MediaQuery.of(context).size.width < 700 ? 1 : 3,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  //padding: const EdgeInsets.all(10.0),
                  children: [
                    Container(
                      //  margin: EdgeInsets.all(20),
                      color: Color(0xFFfef8f7),

                      height: double.infinity,
                      width: 200,

                      child: Column(
                        children: [
                          Container(
                            color: Color(0xFFf0534f),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Pending",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(
                                      //<-- SEE HERE
                                      MaterialCommunityIcons.dots_vertical,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(), //<-- SEE HERE
                                      padding: EdgeInsets.all(8),
                                      backgroundColor: Color(0xFFa83939),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    width: 2.0,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Web redsigning",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Icon(EvilIcons.chevron_down),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: LinearPercentIndicator(
                                          //width: 1,
                                          lineHeight: 8.0,
                                          percent: 0.9,
                                          progressColor: Colors.blue,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("70%"),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(EvilIcons.clock),
                                      ),
                                      Text("Sep 26"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          child: Text(
                                            "High",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Color(0xFFfee2e7),
                                            textStyle: TextStyle(
                                              fontSize: 08,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //margin: EdgeInsets.all(20),
                      color: Color(0xFFe7f3fe),
                      height: 600,
                      width: 200,

                      child: Column(
                        children: [
                          Container(
                            color: Color(0xFF42a5f4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Progress",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(
                                      //<-- SEE HERE
                                      MaterialCommunityIcons.dots_vertical,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(), //<-- SEE HERE
                                      padding: EdgeInsets.all(8),
                                      backgroundColor: Color(0xFF2e73ab),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //color: Colors.white,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 235, 235, 235),
                                  width: 2.0,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Web redsigning",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Icon(EvilIcons.chevron_down),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: LinearPercentIndicator(
                                          //width: 1,
                                          lineHeight: 8.0,
                                          percent: 0.9,
                                          progressColor: Colors.blue,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("70%"),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(EvilIcons.clock),
                                      ),
                                      Text("Sep 26"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          child: Text(
                                            "Normal",
                                            style: TextStyle(
                                                color: Color(0xFFf39e47)),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Color(0xFFfff3e0),
                                            textStyle: TextStyle(
                                              fontSize: 08,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.all(20),
                      color: Color(0xFFedf7ed),
                      height: 600,
                      width: 200,
                      child: Column(
                        children: [
                          Container(
                            color: Color(0xFF4caf50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Completed",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(
                                      //<-- SEE HERE
                                      MaterialCommunityIcons.dots_vertical,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(), //<-- SEE HERE
                                      padding: EdgeInsets.all(8),
                                      backgroundColor: Color(0xFF347b38),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            child: Text(
                              " Add New Task ",
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 650,
            width: double.infinity,
            child: Calender(),
          ),
          const SizedBox(
            width: 20,
          ),

          CreateMileStone(),

          const SizedBox(
            width: 20,
          ),

          User_details(),
        ],
      ),
      flex: 2,
    );
  }

  Expanded redialGraph() {
    var chartData = _chartData;
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 235, 235, 235),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Project Budget',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 300,
                      width: double.infinity,
                      child: Scaffold(
                          body: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              primaryYAxis: NumericAxis(
                                  minimum: 0, maximum: 40, interval: 10),
                              tooltipBehavior: _tooltip,
                              series: <ChartSeries<_ChartData, String>>[
                            ColumnSeries<_ChartData, String>(
                                dataSource: data,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                name: 'Gold',
                                color: Color.fromRGBO(8, 142, 255, 1))
                          ]))),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        child: SfCartesianChart(
                          primaryXAxis: DateTimeAxis(),
                          series: <ChartSeries>[
                            // Renders line chart
                            LineSeries<SalesData, DateTime>(
                                dataSource: saleschartData,
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectBreackDown(),
                    ));
              },
              child: const Text(
                'Go to Project Breakdown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Expanded bridge() {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Bridge',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                height: 1.5,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              Text(
                "view more",
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4)),
        height: 200,
      ),
    );
  }

  Expanded workStatus() {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'work status',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                height: 1.5,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("No Project work created"),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4)),
        height: 200,
      ),
    );
  }

  Expanded siteWeather() {
    return Expanded(
      child: Weather(),
    );
  }

  Container Weather() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Site weather',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              height: 1.5,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  MaterialCommunityIcons.weather_partly_cloudy,
                  size: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Partly cloudy', style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('High: 62 °F',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Low: 62 °F',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Wind: 5 MPS, WSW',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Humidity: 77%',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Precipitions: 0.0 in',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 1.5,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Show More',
                  style: TextStyle(fontSize: 15, color: blue),
                ),
                Icon(
                  MaterialIcons.keyboard_arrow_down,
                  size: 18,
                  color: blue,
                )
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 235, 235, 235),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4)),
    );
  }

  Expanded quickLinks() {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quick Links',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 1.5,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: const [
                          Icon(MaterialCommunityIcons.google_spreadsheet),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 92, 91, 91),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 235, 235, 235),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: const [
                              Icon(Icons.add),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Sheet'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Column(
                    children: [
                      Row(
                        children: const [
                          Icon(AntDesign.team),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 92, 91, 91),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 235, 235, 235),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: const [
                              Icon(Icons.add),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Members'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  Row bodyContent(projectData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Teczo ${projectData['projectName']}',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Text(
                  '''Here's what's happening on your project today.''',
                  style: TextStyle(color: Color.fromARGB(255, 68, 66, 66)),
                ),
              ],
            ),
          ),
        ),
        MediaQuery.of(context).size.width > 1000
            ? Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/body_image.svg',
                      theme: const SvgTheme(currentColor: Colors.green),
                      fit: BoxFit.none,
                    ),
                    SvgPicture.asset(
                      'assets/images/body_image1.svg',
                      fit: BoxFit.none,
                    ),
                  ],
                ),
              )
            : Expanded(
                child: Container(),
                flex: 0,
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('300 Mission Street'),
                Text('San Francisco, CA'),
                Text('94105 United States'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
