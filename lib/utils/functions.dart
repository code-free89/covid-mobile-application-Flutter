import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';

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
