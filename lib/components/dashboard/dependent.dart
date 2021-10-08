import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/button.dart';
import 'package:covid/components/dashboard/dependents/dependent-item.dart';
import 'package:covid/components/textbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManageDependent extends StatefulWidget {
  const ManageDependent({Key? key}) : super(key: key);

  @override
  _ManageDependentState createState() => _ManageDependentState();
}

class _ManageDependentState extends State<ManageDependent> {
  List<Map<String, dynamic>> dependents = [];
  void getDependents() async {
    try {
      final uID = FirebaseAuth.instance.currentUser!.uid;
      List<Map<String, dynamic>> dependencies = (await FirebaseFirestore
              .instance
              .collection("dependent")
              .where("user_id", isEqualTo: uID)
              .get())
          .docs
          .map((e) => e.data())
          .toList();
      setState(() {
        dependents = dependencies;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getDependents();
    super.initState();
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
        title: Text("Manage Dependents"),
        actions: <Widget>[
          new Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox(
                    value: "My Dependents",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    padding: 10,
                  ),
                  TextBox(
                    value:
                        "Node: Please add only dependents who do not have access to a smartphone.",
                    fontSize: 12,
                    lineHeight: 1.3,
                    fontColor: Colors.black54,
                    padding: 20,
                  ),
                  ...(dependents
                      .map((dependent) => DependentItem(
                            name: dependent["name"],
                            relation: dependent["relation"],
                          ))
                      .toList()),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerRight,
        child: Button(
          width: 100,
          label: "Add Vaccination Dependent",
          onPressed: () {
            Navigator.pushNamed(context, "/addDependents");
          },
        ),
      ),
    );
  }
}
