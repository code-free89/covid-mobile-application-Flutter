import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/models/user.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  Map<String, dynamic> userData = {};
  @override
  void initState() {
    setState(() {
      userData = getUserData(context);
    });
    if (userData["isFirstTimeLogin"] == true) {
      userData["isFirstTimeLogin"] = false;
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userData);
    }
    List<String> nameArray = userData["name"].toString().split(" ");
    for (int i = 0; i < nameArray.length; i++)
      setState(() {
        name += nameArray[i][0].toUpperCase();
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            value: userData["name"],
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
                            value: userData["email"],
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
                            value: userData["passportNo"],
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
                            value: userData["state"],
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
                          // Image(
                          //   image: AssetImage('assets/images/img1.png'),
                          //   fit: BoxFit.fill,
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      child: Image(
                        image: AssetImage('assets/images/sampleQRCode.png'),
                        fit: BoxFit.fill,
                        height: 150,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextBox(
                              value:
                                  "This is the QR code for your MySejahtera profile. Please show this to authorities when requested",
                              fontColor: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/images/img1.png'),
                            fit: BoxFit.fill,
                            height: 150,
                          ),
                          Image(
                            image: AssetImage('assets/images/img2.png'),
                            fit: BoxFit.fill,
                            height: 150,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
