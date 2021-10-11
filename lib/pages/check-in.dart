import 'package:covid/components/button.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/pages/check-out.dart';
import 'package:covid/pages/qr-result.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  bool _isScrolled = false;
  final ScrollController _scrollController = new ScrollController();
  late Map<String, dynamic> userData;

  @override
  void initState() {
    _scrollController.addListener(() {
      double curPos = _scrollController.position.pixels;
      setState(() {
        _isScrolled = curPos > 150 ? true : false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userData =
        Provider.of<AuthProvider>(context, listen: true).userData.toJson();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42,
        backgroundColor: AppStyles.primaryColor,
        title: !_isScrolled
            ? Text(
                "Check-in",
                style: TextStyle(fontSize: 30),
              )
            : Center(
                child: Text("Check-in"),
              ),
        leading: Container(),
        leadingWidth: 0,
        shadowColor: Colors.transparent,
        actions: [
          Row(
            children: [
              Icon(
                Icons.autorenew,
                size: 23,
              ),
              TextButton(
                onPressed: () {},
                child: TextBox(
                  value: "Refresh Status",
                  fontColor: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: userData.isNotEmpty
              ? Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: AppStyles.primaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "assets/images/logoMy.svg",
                              width: 120,
                              height: 120,
                            ),
                            SizedBox(height: 20),
                            TextBox(
                              value: userData["name"].toString().toUpperCase(),
                              fontColor: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              padding: 10,
                            ),
                            TextBox(
                              value: userData["passportNo"],
                              fontColor: Colors.white,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue[300],
                                ),
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/Covid19RiskStatusWhite.svg",
                                      width: 35,
                                      height: 35,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextBox(
                                          value: "COVID-19 Risk Status",
                                          fontColor: Colors.white,
                                          fontSize: 14,
                                          padding: 10,
                                        ),
                                        TextBox(
                                          value: "Low Risk No Symptom",
                                          fontWeight: FontWeight.w500,
                                          fontColor: Colors.white,
                                          fontSize: 17,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFFFDD774),
                                ),
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/Covid19ImmunizationStatus.svg",
                                      width: 33,
                                      height: 33,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextBox(
                                          value: "COVID-19 Vaccination Status",
                                          fontSize: 14,
                                          padding: 10,
                                        ),
                                        TextBox(
                                          value: "Fully Vaccinated",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            userData["last_checkin"] != null &&
                                    userData["last_checkin"] != ""
                                ? Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: double.infinity,
                                      padding: EdgeInsets.all(15),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            right: 0,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, "/checkInHistory");
                                              },
                                              child: TextBox(
                                                value: "History",
                                                fontColor:
                                                    AppStyles.primaryColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: TextBox(
                                              value: "Checked-out",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/shopPop.svg",
                                                width: 58,
                                                height: 58,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextBox(
                                                    value: "Last Check-in",
                                                    fontSize: 11,
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: TextBox(
                                                      value: userData[
                                                              "last_checkin_address"]
                                                          .toString()
                                                          .replaceAll("_", " "),
                                                      fontSize: 17,
                                                      padding: 5,
                                                    ),
                                                  ),
                                                  TextBox(
                                                    value: userData[
                                                        "last_checkin"],
                                                    fontSize: 12,
                                                    fontColor: Colors.black54,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        padding: EdgeInsets.all(10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Button(
          onPressed: () async {
            String barcodeScanRes;
            barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                "#ff6666", "Cancel", true, ScanMode.QR);
            print(barcodeScanRes);
            if (barcodeScanRes.contains("qrscan")) {
              String location = "";
              if (barcodeScanRes.contains("&ln=")) {
                int startIndex = barcodeScanRes.indexOf("ln=") + 3;
                int endIndex = barcodeScanRes.indexOf('&', startIndex);
                location = barcodeScanRes.substring(startIndex, endIndex);
              } else if (barcodeScanRes.contains("&eln=")) {
                int startIndex = barcodeScanRes.indexOf("eln=") + 4;
                int endIndex = barcodeScanRes.indexOf('&formType', startIndex);
                location = barcodeScanRes.substring(startIndex, endIndex);
                location = utf8.decode(base64.decode(location.toString()));
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckOutPage(
                    location: location,
                  ),
                ),
              );
            } else if (barcodeScanRes.contains("https://mysejahtera.com")) {
              launch(barcodeScanRes);
            } else if (barcodeScanRes.contains("digital-certificate")) {
              launch(barcodeScanRes);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRScanResultPage(
                    barCodeResult: barcodeScanRes,
                  ),
                ),
              );
            }
          },
          label: "Check-in",
        ),
      ),
    );
  }
}
