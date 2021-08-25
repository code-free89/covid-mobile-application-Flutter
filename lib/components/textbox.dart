import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String value;
  final Color fontColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double padding;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  const TextBox(
      {this.value = "",
      this.fontColor = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 10,
      this.fontStyle = FontStyle.normal,
      this.padding = 3,
      this.textAlign = TextAlign.start,
      Key? key})
      : super(key: key);

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: widget.padding),
      child: Text(
        widget.value,
        textAlign: widget.textAlign,
        style: TextStyle(
          color: widget.fontColor,
          fontWeight: widget.fontWeight,
          fontSize: widget.fontSize,
          fontStyle: widget.fontStyle,
        ),
      ),
    );
  }
}
