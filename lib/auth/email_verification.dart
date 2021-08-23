import 'package:covid/components/button.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    void onSubmit() async {
      User user = FirebaseAuth.instance.currentUser!;
      print(user);
      // ignore: unnecessary_null_comparison
      if (user == null) return;
      if (user.emailVerified) {
        Navigator.pushNamed(context, "/setupProfile1");
      } else {
        showToast("Please check your email for verification");
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
          height: MediaQuery.of(context).size.height - 90,
          padding: EdgeInsets.only(top: 100, left: 25, bottom: 30, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox(
                    value: "Email verification",
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    padding: 20,
                  ),
                  TextBox(
                    value: "Please check your email for verification link",
                    fontColor: Colors.black45,
                    fontSize: 15,
                    padding: 40,
                  ),
                  Button(
                    onPressed: () {
                      onSubmit();
                    },
                    label: "I already verified",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Center(
                      child: Text(
                        "Resend verification email",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
