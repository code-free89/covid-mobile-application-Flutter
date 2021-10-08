import 'package:covid/components/button.dart';
import 'package:covid/components/phone.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/components/textedit.dart';
import 'package:covid/pages/auth/email_verification.dart';
import 'package:covid/pages/auth/verification.dart';
import 'package:covid/utils/functions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SetupProfile1 extends StatefulWidget {
  final String phone;
  final String email;
  final String setupType;
  const SetupProfile1(
      {this.phone = "", this.email = "", required this.setupType, Key? key})
      : super(key: key);

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
    if (widget.email != "")
      setState(() {
        phoneNumber = widget.phone;
        emailController = new TextEditingController(text: widget.email);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onSubmit() async {
      try {
        var userData = getUserData(context);
        if (nameController.value.text == "" ||
            passportController.value.text == "" ||
            ageController.text == "" ||
            phoneNumber == "")
          showToast("Please input all data");
        else {
          userData["name"] = nameController.value.text;
          userData["passportNo"] = passportController.value.text;
          userData["age"] = int.parse(ageController.value.text);
          User? user = FirebaseAuth.instance.currentUser;

          // All conditions are true
          if (user!.emailVerified &&
              user.phoneNumber != "" &&
              user.phoneNumber != null) {
            Navigator.pushNamed(context, "/setupProfile2");
            return;
          }

          if (!EmailValidator.validate(emailController.value.text)) {
            showToast("Invalid email address");
            return;
          }
          if (phoneNumber.length < 5) {
            showToast("Please input phone number");
            return;
          }
          // setupProfile by email
          if (widget.setupType == "email") {
            userData["phoneNumber"] = phoneNumber;
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phoneNumber,
              verificationCompleted: (PhoneAuthCredential user) {
                print("phone auth completed");
              },
              verificationFailed: (e) {
                showToast("Invalid phone number");
              },
              codeSent: (String verificationId, int? resendToken) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Verification(
                      verificationId: verificationId,
                      verifyType: "verify",
                    ),
                  ),
                );
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          } else {
            // setupProfile by phone number
            try {
              await user.updateEmail(emailController.value.text);
              await user.updatePassword("123456");
              await user.sendEmailVerification();
              userData["email"] = emailController.value.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailVerification(verifyType: "verify"),
                ),
              );
            } catch (e) {
              showToast("Email already exist");
              print(e);
            }
          }
          setUserData(context, userData);
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
                    readOnly: widget.email != "" ? true : false,
                  ),
                  TextEdit(
                      labelText: "Full Name",
                      hintText: "Full Name",
                      controller: nameController),
                  PhoneNumberInput(
                    setPhoneNumber: setPhoneNumber,
                    initialValue: widget.phone != "" ? widget.phone : "",
                  ),
                  TextEdit(
                      labelText: "NRIC / Passport No",
                      hintText: "NRIC / Passport No",
                      type: "number",
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
