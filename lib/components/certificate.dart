import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

class CertificatCard extends StatefulWidget {
  final String title;
  final String date;
  final String manufacturer;
  final String batch;
  const CertificatCard(
      {this.title = "",
      this.date = "",
      this.manufacturer = "",
      this.batch = "",
      Key? key})
      : super(key: key);

  @override
  _CertificatCardState createState() => _CertificatCardState();
}

class _CertificatCardState extends State<CertificatCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextBox(
              value: widget.title,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              padding: 15,
            ),
          ],
        ),
        Row(
          children: [
            TextBox(
              value: "Date: ",
              fontSize: 14,
              fontColor: Colors.black54,
            ),
            TextBox(
              value: widget.date,
              fontSize: 12,
              fontColor: Colors.black54,
            ),
          ],
        ),
        TextBox(
          value: "Manufacturer: ${widget.manufacturer}",
          fontSize: 14,
          fontColor: Colors.black54,
        ),
        Row(
          children: [
            TextBox(
              value: "Batch: ",
              fontSize: 14,
              fontColor: Colors.black54,
            ),
            TextBox(
              value: widget.batch,
              fontSize: 14,
              fontColor: Colors.black54,
            ),
          ],
        ),
      ],
    );
  }
}
