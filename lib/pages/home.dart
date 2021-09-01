import 'dart:io';

import 'package:covid/pages/check-in.dart';
import 'package:covid/pages/dashboard.dart';
import 'package:covid/pages/profile.dart';
import 'package:covid/pages/statistics.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int initialPage;
  const HomePage({this.initialPage = 0, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    DashboardPage(),
    StatisticsPage(),
    CheckInPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    _currentIndex = widget.initialPage;
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
              label: "MySejahtera",
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
