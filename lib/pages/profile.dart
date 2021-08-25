import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/models/user.dart';
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
  @override
  void initState() {
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
        decoration: BoxDecoration(color: Colors.red),
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
                            value: "SM",
                            fontWeight: FontWeight.bold,
                            fontColor: AppStyles.primaryColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
