import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/models/user.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 2,
    fontSize: 15,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.blue,
    textColor: Colors.blue,
  );
}

Map<String, dynamic> getUserData(BuildContext context) {
  return Provider.of<AuthProvider>(context, listen: false).userData.toJson();
}

void setUserData(BuildContext context, Map<String, dynamic> value) {
  UserData data = UserData();
  data.fromJson(value);
  Provider.of<AuthProvider>(context, listen: false).userData = data;
}

void setUserDB(String userID, Map<String, dynamic> data) {
  FirebaseFirestore.instance.collection("users").doc(userID).set(data);
}

Future<Map<String, dynamic>> getUserDB(
    BuildContext context, String userID) async {
  Map<String, dynamic> userData =
      (await FirebaseFirestore.instance.collection("users").doc(userID).get())
              .data() ??
          {};
  return userData;
}

Future<Map<String, dynamic>> getVaccineDataByID(String vaccinID) async {
  return (await FirebaseFirestore.instance
              .collection("vaccines")
              .doc(vaccinID)
              .get())
          .data() ??
      {};
}

Future<List<Map<String, dynamic>>> getNews() async {
  return (await FirebaseFirestore.instance
          .collection("news")
          .orderBy("timestamp")
          .get())
      .docs
      .map((e) => e.data())
      .toList();
}

Future<Map<String, dynamic>> getStatisticsUpdate() async {
  return (await FirebaseFirestore.instance
              .collection("statistics")
              .doc("update")
              .get())
          .data() ??
      {};
}

Future<Map<String, dynamic>> getStatisticsStates() async {
  return (await FirebaseFirestore.instance
              .collection("statistics")
              .doc("states")
              .get())
          .data() ??
      {};
}

Future<Map<String, dynamic>> getStatisticsGlobal() async {
  return (await FirebaseFirestore.instance
              .collection("statistics")
              .doc("global")
              .get())
          .data() ??
      {};
}

String generateDOB(String date) {
  int year = int.parse(date.substring(0, 2));
  int month = int.parse(date.substring(2, 4));
  int day = int.parse(date.substring(4, 6));
  DateTime now = DateTime(year < 30 ? year + 2000 : year + 1900, month, day);
  var formatter = new DateFormat("dd MMMM yyyy");
  date = formatter.format(now);
  return date;
}

String generateCurrentDate() {
  DateTime now = DateTime.now();
  var formatter = new DateFormat("dd MMMM yyyy");
  String date = formatter.format(now);
  return date;
}
