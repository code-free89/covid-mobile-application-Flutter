import 'package:covid/components/button.dart';
import 'package:covid/components/phone.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/components/textedit.dart';
import 'package:covid/utils/functions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userData = getUserData(context);
    if (userData["email"] != "") {
      setState(() {
        emailController.value = new TextEditingValue(text: userData["email"]);
      });
    }
    if (userData["phoneNumber"] != "") {
      setState(() {
        phoneNumber = userData["phoneNumber"];
      });
    }

    void onSubmit() {
      try {
        if (nameController.value.text == "" ||
            passportController.value.text == "" ||
            ageController.text == "" ||
            phoneNumber == "")
          showToast("Please input all data");
        else {
          userData["name"] = nameController.value.text;
          userData["passportNo"] = passportController.value.text;
          userData["age"] = int.parse(ageController.value.text);
          if (userData["email"] != "")
            userData["phoneNumber"] = phoneNumber;
          else if (!EmailValidator.validate(emailController.value.text)) {
            showToast("Invalid email address");
            return;
          } else
            userData["email"] = emailController.value.text;
          setUserData(context, userData);
          Navigator.pushNamed(context, "/setupProfile2");
        }
      } catch (e) {
        print(e);
      }
    }

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
                    controller: emailController,
                    readOnly: emailController.value.text != "" ? true : false,
                  ),
                  TextEdit(
                      labelText: "Full Name",
                      hintText: "Full Name",
                      controller: nameController),
                  PhoneNumberInput(
                    setPhoneNumber: setPhoneNumber,
                    initialValue: userData["phoneNumber"] != ""
                        ? userData["phoneNumber"]
                        : "",
                  ),
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
                      onSubmit();
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
