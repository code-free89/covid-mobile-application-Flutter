import 'dart:convert';

import 'package:covid/components/profile/status-card.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

class QRScanResultPage extends StatefulWidget {
  final String barCodeResult;
  const QRScanResultPage({required this.barCodeResult, Key? key})
      : super(key: key);

  @override
  _QRScanResultPageState createState() => _QRScanResultPageState();
}

class _QRScanResultPageState extends State<QRScanResultPage> {
  String name = "";
  String time = "";
  Map<String, dynamic> userData = {};
  @override
  void initState() {
    userData = json.decode(widget.barCodeResult);
    List<String> nameArray = userData["name"].toString().split(" ");
    for (int i = 0; i < nameArray.length; i++)
      setState(() {
        name += nameArray[i][0].toUpperCase();
      });
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy,').add_jm().format(now);
    setState(() {
      time = "As of $formattedDate";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: AppStyles.primaryColor,
        leading: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 40,
          ),
        ),
        title: Text("QR Code Results"),
        centerTitle: true,
        actions: [
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () async {
              String barcodeScanRes;
              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666", "Cancel", true, ScanMode.QR);
            },
            icon: Icon(
              Icons.crop_free,
              size: 25,
            ),
          ),
        ],
      ),
      body: userData.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xFFE0E0E0)),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppStyles.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBox(
                                  value:
                                      userData["name"].toString().toUpperCase(),
                                  fontSize: 14,
                                ),
                                TextBox(
                                  value: "Low Risk No Symptom",
                                  fontSize: 10,
                                  fontColor: Colors.black38,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextBox(
                          value: "IC / Passport No: ${userData["passportNo"]}",
                          fontSize: 14,
                          padding: 8,
                        ),
                        TextBox(
                          value: time,
                          fontSize: 14,
                          padding: 8,
                        ),
                        Image(
                          image:
                              AssetImage("assets/images/LowRiskNoSymptoms.png"),
                          width: double.infinity,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: RiskCard(
                                  title: "Current Location Risk: ",
                                  value: "Red Zone"),
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
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
