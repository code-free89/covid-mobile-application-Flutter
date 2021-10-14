import 'package:covid/components/textbox.dart';
import 'package:covid/models/user.dart';
import 'package:flutter/material.dart';

Widget PendingWidget(
    BuildContext context, dynamic userData, dynamic dose1Data) {
  UserData uData = new UserData();
  uData.fromJson(userData);
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: Column(
      children: [
        TextBox(
          value: userData["name"],
          fontSize: 20,
          fontWeight: FontWeight.w500,
          padding: 10,
        ),
        TextBox(
          value: userData["passportNo"],
          fontSize: 20,
          padding: 10,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBox(
                value: "Dose 1:",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                padding: 10,
              ),
              TextBox(
                value: "Date: ${uData.dose1_date}",
                fontSize: 13,
                fontColor: Colors.black54,
                padding: 5,
              ),
              TextBox(
                value: "Manufacturer: ${dose1Data["manufacturer"]}",
                fontSize: 13,
                fontColor: Colors.black54,
                padding: 5,
              ),
              TextBox(
                value: "Facility: ${dose1Data["facility"]}",
                fontSize: 13,
                fontColor: Colors.black54,
                padding: 5,
              ),
              TextBox(
                value: "Batch: ${dose1Data["batch"]}",
                fontSize: 13,
                fontColor: Colors.black54,
                padding: 45,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
