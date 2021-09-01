import 'package:covid/components/button.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  bool _isScrolled = false;
  final ScrollController _scrollController = new ScrollController();
  var userData;

  @override
  void initState() {
    _scrollController.addListener(() {
      double curPos = _scrollController.position.pixels;
      setState(() {
        _isScrolled = curPos > 150 ? true : false;
      });
    });
    userData = getUserData(context);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          TextButton(
            onPressed: () {},
            child: TextBox(
              value: "History",
              fontColor: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: AppStyles.primaryColor,
                ),
                height: 220,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
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
                  },
                  label: "Check-in",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                children: [
                  Image(
                    image: AssetImage("assets/images/logo-checkin.png"),
                    width: 120,
                  ),
                  SizedBox(height: 25),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          TextBox(
                            value: userData["name"],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            padding: 10,
                          ),
                          TextBox(
                            value: "Low Risk No Symptom",
                            fontSize: 15,
                            padding: 5,
                          ),
                          TextBox(
                            value: userData["phoneNumber"],
                            fontSize: 15,
                            fontColor: Colors.black54,
                          ),
                          Divider(),
                          SvgPicture.asset("assets/images/checkin.svg",
                              width: 200),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
