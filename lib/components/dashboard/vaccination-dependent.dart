import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/dashboard/dependents/dependent-item.dart';
import 'package:covid/components/textbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VaccinationDependent extends StatefulWidget {
  const VaccinationDependent({Key? key}) : super(key: key);

  @override
  _VaccinationDependentState createState() => _VaccinationDependentState();
}

class _VaccinationDependentState extends State<VaccinationDependent> {
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
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBox(
                  value: "Manage Vaccination Dependent",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  padding: 20,
                ),
                // ...(dependents
                //     .map((dependent) => DependentItem(
                //           name: dependent["name"],
                //           relation: dependent["relation"],
                //           isVaccine: true,
                //         ))
                //     .toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
