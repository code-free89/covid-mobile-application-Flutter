import 'package:covid/components/dashboard/vaccination-dependent.dart';
import 'package:covid/components/dashboard/vaccination-information.dart';
import 'package:covid/components/dashboard/vaccination-status.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class VaccinationWidget extends StatefulWidget {
  const VaccinationWidget({Key? key}) : super(key: key);

  @override
  _VaccinationWidgetState createState() => _VaccinationWidgetState();
}

class _VaccinationWidgetState extends State<VaccinationWidget> {
  int currentPage = 0;
  late Map<String, dynamic> userData;
  String name = "";
  List<Widget> statusTabs = [
    VaccinationStatus(),
    VaccinationDependent(),
    VaccinationInformation(),
  ];

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userData = getUserData(context);
      List<String> nameArray = userData["name"].toString().split(" ");
      for (int i = 0; i < nameArray.length; i++)
        setState(() {
          name += nameArray[i][0].toUpperCase();
        });
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: InkWell(
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        title: Text("Vaccination"),
        actions: <Widget>[
          new Container(),
        ],
      ),
      drawerEnableOpenDragGesture: false,
      endDrawer: Container(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              leading: InkWell(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: 35,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              shadowColor: Colors.transparent,
              title: Text("Vaccination"),
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: statusTabs[currentPage],
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) => Container(
          height: 310,
          padding: EdgeInsets.all(10),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFDFDFDF)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppStyles.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      TextBox(value: 'Vaccine for ', fontSize: 14),
                      TextBox(
                        value: userData["name"],
                        fontSize: 15,
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  dense: false,
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    bottom: 0,
                    right: 10,
                  ),
                  horizontalTitleGap: 10,
                  onTap: () {
                    setState(() {
                      currentPage = 0;
                    });
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset("assets/images/home/Dependent.svg",
                      width: 40, height: 40),
                  title: Text('Add Vaccine Dependent'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  dense: false,
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    left: 15,
                    bottom: 0,
                    right: 10,
                  ),
                  horizontalTitleGap: 15,
                  onTap: () {
                    setState(() {
                      currentPage = 1;
                    });
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                      "assets/images/home/VaccineBottle.svg",
                      width: 40,
                      height: 40),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBox(
                        value: "www.vaksincovid.gov.my",
                        fontSize: 13,
                      ),
                      TextBox(
                        value:
                            "Click to know the latest updates on Malaysia's vaccination program",
                        fontColor: Colors.black45,
                        fontSize: 12,
                        lineHeight: 1.2,
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  dense: false,
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    left: 15,
                    bottom: 0,
                    right: 10,
                  ),
                  horizontalTitleGap: 15,
                  onTap: () {
                    launch("https://vaksincovid.gov.my");
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                      "assets/images/home/AdditionalResources.svg",
                      width: 40,
                      height: 40),
                  title: Text('COVID-19 Vaccine Information'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  dense: false,
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    left: 15,
                    bottom: 0,
                    right: 10,
                  ),
                  horizontalTitleGap: 15,
                  onTap: () {
                    setState(() {
                      currentPage = 2;
                    });
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
