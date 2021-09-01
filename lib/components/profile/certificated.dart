import 'package:covid/components/profile/certificate.dart';
import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CertificatedWidget extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> dose1Data;
  final Map<String, dynamic> dose2Data;
  final Function onTap;
  const CertificatedWidget(
      {required this.userData,
      required this.dose1Data,
      required this.dose2Data,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  _CertificatedWidgetState createState() => _CertificatedWidgetState();
}

class _CertificatedWidgetState extends State<CertificatedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(true),
      children: [
        TextBox(
          value: widget.userData["name"],
          fontSize: 20,
          fontWeight: FontWeight.w500,
          padding: 10,
        ),
        TextBox(
          value: widget.userData["passportNo"],
          fontSize: 20,
          padding: 30,
        ),
        TextBox(
          value: widget.userData["address"],
          fontSize: 20,
          padding: 30,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: CertificatCard(
                title: "Dose 1: ",
                date: widget.userData["dose1_date"] ?? "",
                manufacturer: widget.dose1Data["manufacturer"] ?? "",
                batch: widget.dose1Data["batch"] ?? "",
              ),
            ),
            Flexible(
              flex: 1,
              child: CertificatCard(
                title: "Dose 2: ",
                date: widget.userData["dose2_date"] ?? "",
                manufacturer: widget.dose2Data["manufacturer"] ?? "",
                batch: widget.dose2Data["batch"] ?? "",
                isBorder: true,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(
            top: 2,
            left: 8,
            bottom: 2,
            right: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 2),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/big-qr.png",
                    ),
                    width: 30,
                  ),
                  SizedBox(height: 5),
                  TextBox(
                    value: "Show QR",
                    fontColor: Colors.black54,
                  )
                ],
              ),
            ),
            onTap: () {
              widget.onTap();
            },
          ),
        )
      ],
    );
  }
}
