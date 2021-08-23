import 'package:covid/components/button.dart';
import 'package:covid/components/phone.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/components/textedit.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SetupProfile1 extends StatefulWidget {
  const SetupProfile1({Key? key}) : super(key: key);

  @override
  _SetupProfile1State createState() => _SetupProfile1State();
}

class _SetupProfile1State extends State<SetupProfile1> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passportController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  String phoneNumber = "";

  void setPhoneNumber(String number) {
    phoneNumber = number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 25, right: 25, top: 35, bottom: 15),
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
                    value: "Step 1 of 3",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    padding: 10,
                  ),
                  TextBox(
                    value: "Update your personal details",
                    fontSize: 14,
                    fontColor: Colors.black45,
                    padding: 10,
                  ),
                  TextBox(
                    value: "All fields are mandatory.",
                    fontSize: 14,
                    fontColor: Colors.black45,
                    fontStyle: FontStyle.italic,
                    padding: 10,
                  ),
                  TextEdit(
                      labelText: "Email",
                      hintText: "Email",
                      controller: emailController),
                  TextEdit(
                      labelText: "Full Name",
                      hintText: "Full Name",
                      controller: nameController),
                  PhoneNumberInput(setPhoneNumber: setPhoneNumber),
                  TextEdit(
                      labelText: "NRIC / Passport No",
                      hintText: "NRIC / Passport No",
                      controller: passportController),
                  TextEdit(
                    labelText: "Age",
                    hintText: "Age",
                    controller: ageController,
                    type: "number",
                    padding: 20,
                  ),
                  Button(
                    onPressed: () {
                      Navigator.pushNamed(context, "/setupProfile2");
                    },
                    label: "Next",
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
