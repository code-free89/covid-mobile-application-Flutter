import 'package:covid/components/button.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/models/user.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  final String location;
  const CheckOutPage({required this.location, Key? key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late Map<String, dynamic> userData;
  late String date, time, location;
  @override
  void initState() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat("MMM d, y");
    date = formatter.format(now);
    time = DateFormat("hh:mm:ss a").format(now);
    location = widget.location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = getUserData(context);
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
        actions: [
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () async {
              String barcodeScanRes;
              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666", "Cancel", true, ScanMode.QR);
              if (barcodeScanRes.contains("qrscan")) {
                int startIndex = barcodeScanRes.indexOf("ln=") + 3;
                int endIndex = barcodeScanRes.indexOf("&eln=");
                String newLocation =
                    barcodeScanRes.substring(startIndex, endIndex);
                DateTime now = DateTime.now();
                var formatter = new DateFormat("MMM d, y");
                setState(() {
                  location = newLocation;
                  date = formatter.format(now);
                  time = DateFormat("hh:mm:ss a").format(now);
                });
              }
            },
            icon: Icon(
              Icons.crop_free,
              size: 25,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black54,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        color: AppStyles.primaryColor,
                      ),
                      padding: EdgeInsets.only(
                        top: 60,
                        left: 20,
                        bottom: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            "assets/images/logoMy.svg",
                            width: 108,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextBox(
                                value: "Terima Kasih",
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.white,
                                padding: 10,
                              ),
                              TextBox(
                                value: "Pendaftaran anda berjaya!",
                                fontSize: 14,
                                fontColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        children: [
                          TextBox(
                            value: "Maklumat Check-in",
                            fontSize: 16,
                            padding: 18,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              TextBox(
                                value: "Lokasi",
                                fontSize: 11,
                                fontColor: Colors.black54,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  value: location,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBox(
                                    value: "Nama",
                                    fontSize: 11,
                                    fontColor: Colors.black54,
                                  ),
                                  TextBox(
                                    value: userData["name"]
                                        .toString()
                                        .toUpperCase(),
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextBox(
                                    value: "No. Telefon",
                                    fontSize: 11,
                                    fontColor: Colors.black54,
                                  ),
                                  TextBox(
                                    value: userData["phoneNumber"],
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBox(
                                    value: "Tarikh",
                                    fontSize: 11,
                                    fontColor: Colors.black54,
                                  ),
                                  TextBox(
                                    value: date,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextBox(
                                    value: "Masa",
                                    fontSize: 11,
                                    fontColor: Colors.black54,
                                  ),
                                  TextBox(
                                    value: time,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    TextBox(
                                      value: "Status Risiko",
                                      fontColor: Colors.white,
                                      fontSize: 14,
                                      padding: 5,
                                    ),
                                    TextBox(
                                      value: "Low",
                                      fontColor: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.green[800],
                                  ),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 13),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    TextBox(
                                      value: "Status Vaksinasi",
                                      fontColor: Colors.black,
                                      fontSize: 14,
                                      padding: 5,
                                    ),
                                    TextBox(
                                      value: "Fully Vaccinated",
                                      fontColor: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFFDD774),
                                  ),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextBox(
                              value:
                                  "Sila tunjukkan tiket ini kepada pemilik premis apabila diminta",
                              fontSize: 12,
                              lineHeight: 1.4,
                            ),
                          ),
                          SizedBox(width: 10),
                          Image(
                            image: AssetImage('assets/images/img1.png'),
                            fit: BoxFit.fill,
                            height: 40,
                          ),
                          SizedBox(width: 10),
                          Image(
                            image: AssetImage('assets/images/img2.png'),
                            fit: BoxFit.fill,
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/in.svg",
                        width: 75,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 68,
        width: MediaQuery.of(context).size.width,
        child: Button(
          onPressed: () async {
            userData = await getUserDB(
                context, FirebaseAuth.instance.currentUser!.uid);
            userData["last_checkin"] = "$date, $time";
            userData["last_checkin_address"] = location;
            setUserDB(FirebaseAuth.instance.currentUser!.uid, userData);
            setUserData(context, userData);
            Navigator.pop(context);
          },
          label: "Check-out",
        ),
      ),
    );
  }
}
