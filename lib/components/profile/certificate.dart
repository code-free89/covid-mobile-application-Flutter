import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

class CertificatCard extends StatefulWidget {
  final String title;
  final String date;
  final String manufacturer;
  final String facility;
  final String batch;
  final bool isBorder;
  const CertificatCard(
      {this.title = "",
      this.date = "",
      this.manufacturer = "",
      this.facility = "",
      this.batch = "",
      this.isBorder = false,
      Key? key})
      : super(key: key);

  @override
  _CertificatCardState createState() => _CertificatCardState();
}

class _CertificatCardState extends State<CertificatCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xFFFCE6AC),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextBox(
                value: widget.title,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                padding: 10,
              ),
            ],
          ),
          TextBox(
            value: "Date: ${widget.date}",
            fontSize: 14,
            fontColor: Colors.black45,
            lineHeight: 1.2,
          ),
          TextBox(
            value: "Manufacturer: ${widget.manufacturer}",
            fontSize: 14,
            fontColor: Colors.black45,
            lineHeight: 1.2,
            padding: 5,
          ),
          TextBox(
            value: "Facility: ${widget.facility}",
            fontSize: 14,
            fontColor: Colors.black45,
            lineHeight: 1.2,
            padding: 5,
          ),
          TextBox(
            value: "Batch: ${widget.batch}",
            fontSize: 14,
            fontColor: Colors.black45,
          ),
        ],
      ),
    );
  }
}
