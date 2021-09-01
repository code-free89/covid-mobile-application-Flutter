import 'package:covid/components/button.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/constants/questions.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuesetionPage extends StatefulWidget {
  const QuesetionPage({Key? key}) : super(key: key);

  @override
  _QuesetionPageState createState() => _QuesetionPageState();
}

class _QuesetionPageState extends State<QuesetionPage> {
  List<Widget> cards = [];
  List<String> groupValues = [];

  void showSubmitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(0),
          child: Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Center(
                      child: Column(
                        children: [
                          TextBox(
                            value:
                                "Thank you for your response. Please refer to your profile for the latest status",
                            fontSize: 13,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      try {
                        var userData = getUserData(context);
                        userData["isFirstTimeLogin"] = false;
                        setUserData(context, userData);
                        setUserDB(
                            FirebaseAuth.instance.currentUser!.uid, userData);
                      } catch (e) {
                        print(e);
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text("OK", style: AppStyles.defaultText),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(0),
          child: Container(
            width: 200,
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Center(
                      child: Column(
                        children: [
                          TextBox(
                            value: "Note",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            padding: 10,
                          ),
                          TextBox(
                            value:
                                "Please ensure all details are accurate before submitting",
                            fontSize: 13,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: double.infinity,
                            child: Center(
                              child:
                                  Text("Cancel", style: AppStyles.defaultText),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showSubmitDialog();
                          },
                          child: Center(
                            child: Text("OK", style: AppStyles.defaultText),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void onSubmit() {
    for (int i = 0; i < groupValues.length; i++) {
      if (groupValues[i] == "") {
        showToast("Please select all value");
        return;
      }
    }
    showConfirmDialog();
  }

  @override
  void initState() {
    for (int i = 0; i < questions.length; i++) {
      setState(() {
        groupValues.add("");
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: InkWell(
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        title: Text("Questions"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 140,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: questions
                      .map((question) => Card(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBox(
                                    value:
                                        "${question["id"]}. ${question["question"]}",
                                    fontSize: 15,
                                    lineHeight: 1.3,
                                  ),
                                  for (int j = 0;
                                      j < question["answers"].length;
                                      j++)
                                    TextBox(
                                      value: "· ${question["answers"][j]}",
                                      fontSize: 15,
                                      lineHeight: 1.3,
                                    ),
                                  RadioListTile(
                                    title: Text("No/Tidak"),
                                    value: "question${question["id"]}no",
                                    groupValue: groupValues[question["id"] - 1],
                                    onChanged: (value) {
                                      setState(() {
                                        groupValues[question["id"] - 1] =
                                            value.toString();
                                      });
                                    },
                                    contentPadding: EdgeInsets.all(0),
                                    activeColor: Colors.blue,
                                  ),
                                  RadioListTile(
                                    title: Text("Yes/Ya"),
                                    value: "question${question["id"]}yes",
                                    groupValue: groupValues[question["id"] - 1],
                                    onChanged: (value) {
                                      setState(() {
                                        groupValues[question["id"] - 1] =
                                            value.toString();
                                      });
                                      print(groupValues);
                                    },
                                    contentPadding: EdgeInsets.all(0),
                                    activeColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black26),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Button(
                        onPressed: () {
                          onSubmit();
                        },
                        label: "Submit",
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
