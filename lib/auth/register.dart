import 'package:covid/auth/email_verification.dart';
import 'package:covid/auth/verification.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:covid/utils/enums.dart';
import 'package:covid/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:covid/utils/styles.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  LogInMode _logInMode = LogInMode.phone;
  String phoneNumber = "";
  bool _isLoading = false;
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    // setState(() {
    //   _isLoading = false;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _isLoading = false;
    });
    void registerUser() async {
      var userData = getUserData(context);
      userData["email"] = "";
      userData["phoneNumber"] = "";
      setState(() {
        _isLoading = true;
      });
      if (_logInMode == LogInMode.phone) {
        try {
          if (phoneNumber.length > 5) {
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phoneNumber,
              verificationCompleted: (PhoneAuthCredential user) {
                print("phone auth completed");
              },
              verificationFailed: (e) {
                showToast("Invalid phone number");
              },
              codeSent: (String verificationId, int? resendToken) {
                userData["phoneNumber"] = phoneNumber;
                setUserData(context, userData);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Verification(
                      verificationId: verificationId,
                      verifyType: "register",
                    ),
                  ),
                );
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          } else {
            showToast("Invalid phone number");
          }
        } catch (e) {
          showToast("Invalid phone number");
          print(e);
        }
      } else if (_logInMode == LogInMode.email) {
        final String email = emailController.value.text;
        if (email == "" || !EmailValidator.validate(email)) {
          showToast("Invalid email");
          setState(() {
            _isLoading = false;
          });
          return;
        }
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: "123456");
          if (!user.user!.emailVerified) await user.user!.delete();
        } catch (e) {
          print(e);
        }
        try {
          UserCredential user =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: "123456",
          );
          var userData = getUserData(context);
          Provider.of<AuthProvider>(context, listen: false).user = user.user!;
          userData["email"] = email;
          setUserData(context, userData);
          await user.user!.sendEmailVerification();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmailVerification(
                verifyType: "register",
              ),
            ),
          );
        } catch (e) {
          if (e.toString().indexOf("already") >= 0) {
            showToast("Email is already exist.");
          }
          print(e);
        }
      }
      setState(() {
        _isLoading = false;
      });
    }

    return Stack(
      children: [
        Scaffold(
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
              padding:
                  EdgeInsets.only(top: 80, left: 25, bottom: 50, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    fit: BoxFit.fitWidth,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Registration", style: AppStyles.titleText),
                      SizedBox(height: 20),
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
                              maxLength: 15,
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
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                hintText: "Email",
                              ),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        child: Text("Register"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            double.infinity,
                            40,
                          ), // double.infinity is the width and 30 is the height
                        ),
                        onPressed: () => registerUser(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Center(
                          child: Text(
                            "I would like to use ${this._logInMode == LogInMode.phone ? "email" : "phone number"} to register",
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
                  )
                ],
              ),
            ),
          ),
        ),
        _isLoading
            ? Container(
                child: GestureDetector(
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
