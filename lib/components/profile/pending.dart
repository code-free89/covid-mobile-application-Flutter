import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

Widget PendingWidget(
    BuildContext context, dynamic userData, dynamic dose1Data) {
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
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: TextBox(
                  value: "Dose 1:",
                  fontWeight: FontWeight.bold,
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
                  fontColor: Colors.black54,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: TextBox(
                  value: userData["dose1_date"],
                  fontSize: 12,
                  fontColor: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: TextBox(
                  value: "Manufacturer: ",
                  fontSize: 14,
                  fontColor: Colors.black54,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: TextBox(
                  value: dose1Data["manufacturer"],
                  fontSize: 12,
                  fontColor: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: TextBox(
                  value: "Batch: ",
                  fontSize: 14,
                  fontColor: Colors.black54,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: TextBox(
                  value: dose1Data["batch"],
                  fontSize: 12,
                  fontColor: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
