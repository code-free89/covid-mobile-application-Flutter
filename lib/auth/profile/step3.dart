import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/button.dart';
import 'package:covid/components/password.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SetupProfile3 extends StatefulWidget {
  const SetupProfile3({Key? key}) : super(key: key);

  @override
  _SetupProfile3State createState() => _SetupProfile3State();
}

class _SetupProfile3State extends State<SetupProfile3> {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userData = getUserData(context);
    void onSubmit() async {
      if (passwordController.value.text == "" ||
          confirmController.value.text == "")
        showToast("Plase input all data");
      else if (passwordController.value.text != confirmController.value.text)
        showToast("Confirm password isn't the same");
      else {
        try {
          await FirebaseAuth.instance.currentUser!
              .updatePassword(passwordController.value.text);

          CollectionReference<Map<String, dynamic>> usercollection =
              FirebaseFirestore.instance.collection("users");
          await usercollection.add(userData);
          Navigator.pushNamed(context, "/profileSuccess");
        } catch (e) {
          print(e);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.blue,
              size: 40,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 90,
          padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox(
                    value: "Step 3 of 3",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    padding: 10,
                  ),
                  TextBox(
                    value: "Please choose a password",
                    fontSize: 14,
                    fontColor: Colors.black45,
                    padding: 10,
                  ),
                  PasswordInput(controller: passwordController),
                  PasswordInput(
                    controller: confirmController,
                    label: "Confirm Password",
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(bottom: 25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(253, 237, 211, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• Minimum 6 Characters",
                          style: TextStyle(color: Colors.brown, fontSize: 12),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "• Minimum 25 Characters",
                          style: TextStyle(color: Colors.brown, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Button(
                    onPressed: () {
                      onSubmit();
                    },
                    label: "Confirm",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
