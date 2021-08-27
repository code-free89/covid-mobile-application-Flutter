import 'package:covid/components/certificate.dart';
import 'package:covid/components/textbox.dart';
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
  Map<String, dynamic> userData = {};
  Map<String, dynamic> dose1Data = {};
  Map<String, dynamic> dose2Data = {};

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
              print(value);
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
      for (int i = 0; i < nameArray.length; i++)
        setState(() {
          name += nameArray[i][0].toUpperCase();
        });
      getVaccinData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(dose2Data);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Center(
          child: Text("Profile"),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Checkout'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text('Transactions'),
              onTap: () {
                Navigator.pushNamed(context, '/transactionsList');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Logout'),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/login');
                } catch (e) {}
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black12),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppStyles.lightGrayColor,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: TextBox(
                            value: this.name,
                            fontWeight: FontWeight.bold,
                            fontColor: AppStyles.primaryColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBox(
                            value:
                                userData["name"] != "" ? userData["name"] : "",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          TextBox(
                            value: "Low Risk No Symptom",
                            fontSize: 15,
                            fontColor: Colors.black87,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBox(
                            value: "MySJ ID",
                            fontSize: 18,
                          ),
                          TextBox(
                            value: userData["email"] != ""
                                ? userData["email"]
                                : "",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBox(
                            value: "IC / Passport No",
                            fontSize: 18,
                          ),
                          TextBox(
                            value: userData["passportNo"] != ""
                                ? userData["passportNo"]
                                : "",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBox(
                            value: "State",
                            fontSize: 18,
                          ),
                          TextBox(
                            value: userData["state"] != ""
                                ? userData["state"]
                                : "",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.cached_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 15),
                          TextBox(
                            value: "Click to refresh your profile",
                            fontSize: 15,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black12,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: TextBox(
                          value: "Refresh",
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      child: TextBox(
                        value: "As of 24 Aug 2021, 8:34 AM",
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Color(0xFF51A6EC)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextBox(
                                value: "Status Risika COVID-19",
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.white,
                                fontSize: 12,
                              ),
                              TextBox(
                                value: "COVID-19 Risk Status",
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.white,
                                fontSize: 12,
                                padding: 15,
                              ),
                              TextBox(
                                value: "Risiko Rendah / Low Risk",
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.white,
                                fontSize: 18,
                              ),
                            ],
                          ),
                          Image(
                            image: AssetImage('assets/images/img1.png'),
                            fit: BoxFit.fill,
                            width: 80,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Image(
                        image: AssetImage('assets/images/sampleQRCode.png'),
                        fit: BoxFit.fill,
                        height: 250,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Color(0xFFECECEC)),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextBox(
                              value:
                                  "This is the QR code for your MySejahtera profile. Please show this to authorities when requested",
                              fontColor: Colors.black45,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 10),
                          Image(
                            image: AssetImage('assets/images/img1.png'),
                            fit: BoxFit.fill,
                            height: 50,
                          ),
                          SizedBox(width: 10),
                          Image(
                            image: AssetImage('assets/images/img2.png'),
                            fit: BoxFit.fill,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              userData["dose1"] != ""
                  ? Container(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 65),
                            decoration: BoxDecoration(
                              color: userData["dose2"] != ""
                                  ? Color(0xFFF0D272)
                                  : Colors.white,
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.only(
                                top: 70, left: 20, bottom: 10, right: 20),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 2, color: Colors.black87),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(bottom: 15),
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      TextBox(
                                        value: "COVID-19 Vaccination",
                                        fontSize: 20,
                                        fontColor: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      TextBox(
                                        value: "Digital Certificate",
                                        fontSize: 15,
                                        padding: 15,
                                      )
                                    ],
                                  ),
                                ),
                                TextBox(
                                  value: userData["name"],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                TextBox(
                                  value: userData["passportNo"],
                                  fontSize: 18,
                                  padding: 20,
                                ),
                                TextBox(
                                  value: userData["address"],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  padding: 20,
                                ),
                                dose2Data.isNotEmpty
                                    ? Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: CertificatCard(
                                              title: "Dose 1",
                                              date:
                                                  userData["dose1_date"] ?? "",
                                              manufacturer:
                                                  dose1Data["manufacturer"] ??
                                                      "",
                                              batch: dose1Data["batch"] ?? "",
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: CertificatCard(
                                              title: "Dose 2",
                                              date:
                                                  userData["dose2_date"] ?? "",
                                              manufacturer:
                                                  dose2Data["manufacturer"] ??
                                                      "",
                                              batch: dose2Data["batch"] ?? "",
                                            ),
                                          ),
                                        ],
                                      )
                                    : dose1Data.isNotEmpty
                                        ? Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextBox(
                                                          value: "Dose 1",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          padding: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextBox(
                                                          value: "Date: ",
                                                          fontSize: 14,
                                                          fontColor:
                                                              Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextBox(
                                                          value: userData[
                                                              "dose1_date"],
                                                          fontSize: 12,
                                                          fontColor:
                                                              Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextBox(
                                                          value:
                                                              "Manufacturer: ",
                                                          fontSize: 14,
                                                          fontColor:
                                                              Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextBox(
                                                          value: dose1Data[
                                                              "manufacturer"],
                                                          fontSize: 12,
                                                          fontColor:
                                                              Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextBox(
                                                          value: "Batch: ",
                                                          fontSize: 14,
                                                          fontColor:
                                                              Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextBox(
                                                          value: dose1Data[
                                                              "batch"],
                                                          fontSize: 12,
                                                          fontColor:
                                                              Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                dose2Data.isNotEmpty
                                    ? Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.only(
                                          top: 2,
                                          left: 8,
                                          bottom: 2,
                                          right: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Card(
                                              child: Image(
                                                image: AssetImage(
                                                  "assets/images/sampleQRCode.png",
                                                ),
                                                width: 40,
                                              ),
                                            ),
                                            TextBox(
                                              value: "Scan QR",
                                              fontColor: Colors.black54,
                                            )
                                          ],
                                        ))
                                    : Container(),
                              ],
                            ),
                          ),
                          Positioned(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black54, width: 2),
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 20),
                                    child: Image(
                                      image:
                                          AssetImage('assets/images/mosti.png'),
                                      fit: BoxFit.fill,
                                      width: 80,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
