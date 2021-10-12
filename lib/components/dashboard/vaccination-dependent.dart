import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/dashboard/dependents/dependent-item.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/models/dependent.dart';
import 'package:covid/providers/dataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VaccinationDependent extends StatefulWidget {
  const VaccinationDependent({Key? key}) : super(key: key);

  @override
  _VaccinationDependentState createState() => _VaccinationDependentState();
}

class _VaccinationDependentState extends State<VaccinationDependent> {
  @override
  Widget build(BuildContext context) {
    List<DependentData> dependents =
        Provider.of<DataProvider>(context, listen: true).getDependents;
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
                ...(dependents
                    .map((dependent) => DependentItem(
                          data: dependent,
                          isVaccine: true,
                        ))
                    .toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
