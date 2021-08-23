import 'package:covid/auth/login.dart';
import 'package:covid/auth/profile/step1.dart';
import 'package:covid/auth/profile/step2.dart';
import 'package:covid/auth/profile/step3.dart';
import 'package:covid/auth/profile/success.dart';
import 'package:covid/auth/register.dart';
import 'package:covid/auth/forget.dart';
import 'package:covid/auth/start.dart';
import 'package:covid/auth/verification.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:covid/splash.dart';
import 'package:covid/utils/palett.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/start': (context) => GetStarted(),
        '/login': (context) => LogIn(),
        '/register': (context) => Register(),
        '/reset': (context) => ForgetPassword(),
        '/verification': (context) => Verification(),
        '/setupProfile1': (context) => SetupProfile1(),
        '/setupProfile2': (context) => SetupProfile2(),
        '/setupProfile3': (context) => SetupProfile3(),
        '/profileSuccess': (context) => ProfileSuccess(),
      },
    );
  }
}
