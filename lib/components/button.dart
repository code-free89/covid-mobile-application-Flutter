import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function onPressed;
  final String label;
  const Button({this.label = "", required this.onPressed, Key? key})
      : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text(widget.label),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            double.infinity,
            40,
          ), // double.infinity is the width and 30 is the height
        ),
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }
}
