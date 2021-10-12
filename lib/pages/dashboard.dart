import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/dashboard/status.dart';
import 'package:covid/components/dashboard/tabmenu.dart';
import 'package:covid/models/checkin-history.dart';
import 'package:covid/models/dependent.dart';
import 'package:covid/providers/dataProvider.dart';
import 'package:covid/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isScrolled = false;
  final ScrollController _scrollController = new ScrollController();

  void getDependents() async {
    List<DependentData> dependents = [];
    try {
      final uID = FirebaseAuth.instance.currentUser!.uid;
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          (await FirebaseFirestore.instance
                  .collection("dependent")
                  .where("user_id", isEqualTo: uID)
                  .get())
              .docs;
      List<Map<String, dynamic>> dependencies = [];
      documents.forEach((element) {
        dependencies.add({...element.data(), "id": element.id});
      });
      dependencies.forEach((element) {
        DependentData dependentItem = new DependentData();
        dependentItem.fromJson(element);
        dependents.add(dependentItem);
      });
      Provider.of<DataProvider>(context, listen: false).setDependents =
          dependents;
    } catch (e) {
      print("error => $e");
    }
  }

  void getCheckInHistory() async {
    List<CheckInHistoryData> historyDatas = [];
    try {
      final uID = FirebaseAuth.instance.currentUser!.uid;
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          (await FirebaseFirestore.instance
                  .collection("checkin-history")
                  .where("user_id", isEqualTo: uID)
                  .get())
              .docs;
      List<Map<String, dynamic>> histories = [];
      documents.forEach((element) {
        histories.add(element.data());
      });
      histories.forEach((element) {
        CheckInHistoryData historyItem = new CheckInHistoryData();
        historyItem.fromJson(element);
        historyDatas.add(historyItem);
      });
      Provider.of<DataProvider>(context, listen: false).setHistories =
          historyDatas;
    } catch (e) {
      print("error => $e");
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      double curPos = _scrollController.position.pixels;
      setState(() {
        _isScrolled = curPos > 150 ? true : false;
      });
    });
    getDependents();
    getCheckInHistory();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42,
        backgroundColor: AppStyles.primaryColor,
        title: !_isScrolled
            ? Text(
                "MySejahtera",
                style: TextStyle(fontSize: 30),
              )
            : Center(
                child: Text("MySejahtera"),
              ),
        leading: Container(),
        leadingWidth: 0,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppStyles.primaryColor,
                  ),
                  height: 150,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    DashboardStatusCard(),
                    TabMenu(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
