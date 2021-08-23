import 'package:covid/components/button.dart';
import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

class ProfileSuccess extends StatefulWidget {
  const ProfileSuccess({Key? key}) : super(key: key);

  @override
  _ProfileSuccessState createState() => _ProfileSuccessState();
}

class _ProfileSuccessState extends State<ProfileSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 25, right: 25, top: 180, bottom: 40),
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
                    value: "Registration Successful",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    padding: 15,
                  ),
                  TextBox(
                    value: "Please wait for the activation SMS/email to login",
                    fontColor: Colors.black45,
                    fontSize: 15,
                  ),
                  Button(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    label: "Done",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
