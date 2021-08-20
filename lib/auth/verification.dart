import 'dart:async';

import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController otpController = new TextEditingController();
  Timer _timer = new Timer(Duration.zero, () {});
  int duration = 300;
  bool isLimit = true;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    setState(() {
      duration = 300;
    });
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (duration > 0)
          setState(() {
            duration--;
          });
        else
          setState(() {
            isLimit = false;
            _timer.cancel();
          });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
          padding: EdgeInsets.only(top: 0, left: 25, bottom: 30, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text("OTP verification", style: AppStyles.titleText),
                  Text(
                    "Enter the OTP sent to you registered phone number/email address prince891028@gmail.com",
                    style: AppStyles.grayText10,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "OTP",
                    style: AppStyles.subTitleText,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Didn't receive yet? ",
                            style: AppStyles.grayText15,
                          ),
                          GestureDetector(
                            child: Text(
                              "Resend OTP",
                              style: isLimit
                                  ? AppStyles.disableText
                                  : AppStyles.defaultText,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${duration ~/ 60}m ${duration % 60}s",
                        style: AppStyles.greenText,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "An OTP will be sent to your registered phone number/email. Kindly enter above to register. If you do not receive it within 5 minutes, Kindly try again.",
                    style: AppStyles.grayText12,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        double.infinity,
                        40,
                      ), // double.infinity is the width and 30 is the height
                    ),
                    onPressed: () {},
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
