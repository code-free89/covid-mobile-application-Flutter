import 'package:covid/constants/vaccinationStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VaccinationInformation extends StatefulWidget {
  const VaccinationInformation({Key? key}) : super(key: key);

  @override
  _VaccinationInformationState createState() => _VaccinationInformationState();
}

class _VaccinationInformationState extends State<VaccinationInformation> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 400,
        child: Column(
          children: vaccineInformations
              .map(
                (vaccineInfo) => ListTile(
                  leading: SvgPicture.asset(vaccineInfo["svg"],
                      width: 40, height: 40),
                  title: Text(vaccineInfo["title"]),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  dense: false,
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    left: 15,
                    bottom: 0,
                    right: 10,
                  ),
                  horizontalTitleGap: 15,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
