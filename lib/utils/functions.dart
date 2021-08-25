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

void showAlert({String title = ""}) {
  AlertDialog(
    title: Text("asdf"),
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
    backgroundColor: Colors.greenAccent,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    content: Text("Save successfully"),
  );
}

Map<String, dynamic> getUserData(BuildContext context) {
  return Provider.of<AuthProvider>(context, listen: false).userData.toJson();
}

void setUserData(BuildContext context, Map<String, dynamic> value) {
  Provider.of<AuthProvider>(context, listen: false).userData.fromJson(value);
}
