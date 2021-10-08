import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/models/user.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';

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
  print(data);
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
