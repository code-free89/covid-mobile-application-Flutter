import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

class VaccinationDependent extends StatefulWidget {
  const VaccinationDependent({Key? key}) : super(key: key);

  @override
  _VaccinationDependentState createState() => _VaccinationDependentState();
}

class _VaccinationDependentState extends State<VaccinationDependent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width - 20,
            padding: EdgeInsets.all(20),
            child: TextBox(
              value: "Manage Vaccination Dependent",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
