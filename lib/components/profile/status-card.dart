import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

class RiskCard extends StatefulWidget {
  final Color borderColor;
  final String title;
  final String value;
  const RiskCard(
      {this.borderColor = Colors.red,
      required this.title,
      required this.value,
      Key? key})
      : super(key: key);

  @override
  _RiskCardState createState() => _RiskCardState();
}

class _RiskCardState extends State<RiskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: new LinearGradient(
              stops: [0.04, 0.04], colors: [widget.borderColor, Colors.white]),
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextBox(
              value: widget.title,
              fontColor: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
            TextBox(
              value: widget.value,
              fontColor: widget.borderColor,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
