import 'package:covid/auth/login.dart';
import 'package:covid/auth/register.dart';
import 'package:covid/auth/forget.dart';
import 'package:covid/auth/start.dart';
import 'package:covid/auth/verification.dart';
import 'package:covid/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/start': (context) => GetStarted(),
        '/login': (context) => LogIn(),
        '/register': (context) => Register(),
        '/reset': (context) => ForgetPassword(),
        '/verification': (context) => Verification(),
      },
    );
  }
}
