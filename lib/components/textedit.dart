import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextEdit extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String type;
  final double padding;
  final bool readOnly;
  final int maxLength;
  final TextAlign textAlign;
  final bool isUnderline;
  const TextEdit(
      {this.labelText = "",
      this.hintText = "",
      required this.controller,
      this.type = "string",
      this.padding = 10,
      this.readOnly = false,
      this.maxLength = 100,
      this.textAlign = TextAlign.start,
      this.isUnderline = false,
      Key? key})
      : super(key: key);

  @override
  _TextEditState createState() => _TextEditState();
}

class _TextEditState extends State<TextEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: widget.padding),
      child: TextFormField(
        textAlign: widget.textAlign,
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        inputFormatters: widget.type == "number"
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        decoration: InputDecoration(
          border: widget.isUnderline
              ? UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                )
              : OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
          isDense: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black38),
        ),
        style: TextStyle(
          fontSize: 15,
          color: widget.readOnly ? Colors.black45 : Colors.black,
        ),
        readOnly: widget.readOnly,
      ),
    );
  }
}
