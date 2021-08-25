import 'dart:io';

import 'package:covid/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // User? user = FirebaseAuth.instance.currentUser;
    // print(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 90),
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard_outlined,
                size: 32,
              ),
              label: "Statistics",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_2_outlined,
                size: 32,
              ),
              label: "Check-in",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 32,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
