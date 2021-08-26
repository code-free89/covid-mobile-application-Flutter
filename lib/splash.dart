import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<SplashScreen> {
  // Init variables
  Timer _timer = new Timer(Duration.zero, () {});
  int duration = 3;
  bool isFirebaseConnected = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (isFirebaseConnected == true) {
          _timer.cancel();
          if (FirebaseAuth.instance.currentUser != null) {
            try {
              var userData = (await FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get())
                  .data();
              // setUserData(
              //   context,
              //   (await FirebaseFirestore.instance
              //               .collection("users")
              //               .doc(FirebaseAuth.instance.currentUser!.uid)
              //               .get())
              //           .data() ??
              //       {},
              // );
              print(userData);
              // Navigator.pushNamed(context, "/home");
            } catch (e) {
              print(e);
            }
          } else
            Navigator.popAndPushNamed(context, '/start');
        }
      },
    );
  }

  void sharedPrefInit() async {
    try {
      /// Checks if shared preference exist
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      prefs.getString("app-name");
      await Firebase.initializeApp();
      // print("signing out");
      // await FirebaseAuth.instance.signOut();
      setState(() {
        isFirebaseConnected = true;
      });
    } catch (err) {
      /// setMockInitialValues initiates shared preference
      /// Adds app-name
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues({});
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      prefs.setString("app-name", "covid");
    }
  }

  @override
  void initState() {
    sharedPrefInit();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/splash.png'), fit: BoxFit.cover),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
