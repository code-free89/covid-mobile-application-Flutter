import 'package:covid/components/textbox.dart';
import 'package:covid/utils/enums.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  LogInMode _logInMode = LogInMode.phone;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String phoneNumber = "";

  void onSubmit() async {
    final email = emailController.value.text;
    if (!EmailValidator.validate(email)) {
      showToast("Invalid email");
      return;
    }
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showToast("Reset password link sent");
  }

  @override
  Widget build(BuildContext context) {
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
          height: MediaQuery.of(context).size.height - 90,
          padding: EdgeInsets.only(top: 80, left: 25, bottom: 40, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.fitWidth,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox(
                    value: "Reset password",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontColor: Colors.black,
                    padding: 20,
                  ),
                  TextBox(
                    value: "Registered user ID",
                    fontSize: 15,
                    fontColor: Colors.black45,
                    padding: 10,
                  ),
                  _logInMode == LogInMode.phone
                      ? InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            phoneNumber = number.phoneNumber ?? "";
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                            trailingSpace: false,
                            showFlags: false,
                          ),
                          maxLength: 10,
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          formatInput: true,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            focusColor: Colors.black12,
                            fillColor: Colors.black12,
                            hoverColor: Colors.black12,
                            labelText: "Mobile Number",
                          ),
                          hintText: "Mobile Number",
                        )
                      : TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            hintText: "Email",
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Center(
                          child: Text(
                            "My user ID is ${this._logInMode == LogInMode.phone ? "an email" : "a phone number"}",
                            style: AppStyles.defaultText,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _logInMode = _logInMode == LogInMode.phone
                                ? LogInMode.email
                                : LogInMode.phone;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        double.infinity,
                        40,
                      ), // double.infinity is the width and 30 is the height
                    ),
                    onPressed: () {
                      onSubmit();
                    },
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
