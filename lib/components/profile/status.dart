import 'dart:convert';

import 'package:covid/components/profile/status-card.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:covid/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({Key? key}) : super(key: key);

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  @override
  Widget build(BuildContext context) {
    print(json.encode(getUserData(context)));
    return Card(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            child: TextBox(
              value: Provider.of<AuthProvider>(context, listen: true)
                  .currentDateTime,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          Image(image: AssetImage("assets/images/LowRiskNoSymptoms.png")),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: QrImage(
              data: json.encode(getUserData(context)),
              size: 260,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: RiskCard(
                      title: "Current Location Risk: ", value: "Red Zone"),
                ),
                Flexible(
                  flex: 1,
                  child: RiskCard(
                    borderColor: Colors.green,
                    title: "High Risk Dependent: ",
                    value: "No",
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Color(0xBBECECEC)),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextBox(
                    value:
                        "This is the QR code for your MySejahtera profile. Please show this to authorities when requested",
                    fontColor: Colors.black26,
                    fontSize: 12,
                    lineHeight: 1.3,
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
    );
  }
}
