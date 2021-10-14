import 'dart:math';

import 'package:covid/components/profile/certificated.dart';
import 'package:covid/components/profile/info.dart';
import 'package:covid/components/profile/name.dart';
import 'package:covid/components/profile/pending.dart';
import 'package:covid/components/profile/qr.dart';
import 'package:covid/components/profile/refresh.dart';
import 'package:covid/components/profile/status.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/constants/settings-menu.dart';
import 'package:covid/models/user.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  bool _showFrontSide = false;
  Map<String, dynamic> userData = {};
  Map<String, dynamic> dose1Data = {};
  Map<String, dynamic> dose2Data = {};
  final ScrollController _scrollController = new ScrollController();
  bool _isScrolled = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController = new PageController();

  void getVaccinData() {
    if (userData["dose1"] != null && userData["dose1"] != "") {
      getVaccineDataByID(userData["dose1"]).then((value) => {
            setState(() {
              dose1Data = value;
            })
          });
    }
    if (userData["dose2"] != null && userData["dose2"] != "") {
      getVaccineDataByID(userData["dose2"]).then((value) => {
            setState(() {
              dose2Data = value;
            })
          });
    }
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userData = getUserData(context);
      });
      List<String> nameArray = userData["name"].toString().split(" ");
      for (int i = 0; i < 2; i++)
        setState(() {
          name += nameArray[i][0].toUpperCase();
        });
      getVaccinData();
    }
    _scrollController.addListener(() {
      double curPos = _scrollController.position.pixels;
      setState(() {
        _isScrolled = curPos > 150 ? true : false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserData uData = new UserData();
    uData.fromJson(userData);
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        toolbarHeight: 42,
        backgroundColor: AppStyles.primaryColor,
        title: !_isScrolled
            ? Text(
                "Profile",
                style: TextStyle(fontSize: 30),
              )
            : Center(
                child: Text("Profile"),
              ),
        leading: Container(),
        leadingWidth: 0,
        shadowColor: Colors.transparent,
      ),
      drawerEnableOpenDragGesture: false,
      endDrawer: Container(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left, size: 45),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Center(child: Text("Settings")),
            ),
            body: Container(
              decoration: BoxDecoration(color: Color(0xFFE9E9E9)),
              padding:
                  EdgeInsets.only(top: 10, left: 10, bottom: 100, right: 10),
              child: Card(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppStyles.primaryColor,
                          ),
                        ),
                      ),
                      title: Text('My Personal Details'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      dense: false,
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        bottom: 0,
                        right: 20,
                      ),
                      horizontalTitleGap: 20,
                    ),
                    ...settings
                        .map((setting) => ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF0F0F0),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(10),
                                child: setting["icon"],
                              ),
                              title: Text(setting["title"]),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              dense: false,
                              contentPadding: EdgeInsets.only(
                                top: 0,
                                left: 10,
                                bottom: 0,
                                right: 20,
                              ),
                              horizontalTitleGap: 20,
                              onTap: () {
                                if (setting["title"]
                                    .toString()
                                    .contains("Logout")) {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.popUntil(context, (route) => true);
                                  Navigator.pushNamed(context, "/login");
                                }
                              },
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: AppStyles.primaryColor,
                ),
                height: 150,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  NameCard(name: name),
                  InformationCard(),
                  RefreshCard(),
                  StatusCard(),
                  SizedBox(height: 15),
                  uData.dose1 != ""
                      ? Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 50),
                              decoration: BoxDecoration(
                                color: uData.dose2 != ""
                                    ? Color(0xFFFDD775)
                                    : Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              padding: EdgeInsets.only(
                                  top: 60, left: 20, bottom: 10, right: 20),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 3,
                                          color: uData.dose2 != ""
                                              ? Colors.black87
                                              : Color(0xFFFDD775),
                                        ),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(bottom: 8),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        TextBox(
                                          value: "COVID-19 Vaccination",
                                          fontSize: 23,
                                          fontColor: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          padding: 10,
                                        ),
                                        TextBox(
                                          value: uData.dose2 != ""
                                              ? "Digital Certificate"
                                              : "Status",
                                          fontSize: 20,
                                          padding: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  dose2Data.isNotEmpty
                                      ? AnimatedSwitcher(
                                          duration: Duration(milliseconds: 700),
                                          transitionBuilder:
                                              __transitionBuilder,
                                          child: !_showFrontSide
                                              ? CertificatedWidget(
                                                  userData: userData,
                                                  dose1Data: dose1Data,
                                                  dose2Data: dose2Data,
                                                  onTap: () {
                                                    setState(() {
                                                      _showFrontSide = true;
                                                    });
                                                  },
                                                )
                                              : QRWidget(
                                                  onTap: () {
                                                    setState(() {
                                                      _showFrontSide = false;
                                                    });
                                                  },
                                                ),
                                          layoutBuilder: (widget, list) =>
                                              Stack(
                                            children: [
                                              widget ?? Container(),
                                              ...list
                                            ],
                                          ),
                                        )
                                      : dose1Data.isNotEmpty
                                          ? PendingWidget(
                                              context, userData, dose1Data)
                                          : Container(),
                                ],
                              ),
                            ),
                            Positioned(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 100,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(130, 100)),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Image(
                                      image:
                                          AssetImage("assets/images/mosti.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
