import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function onPressed;
  final String label;
  final double width;
  final Color color;
  final Color bgColor;
  final bool shadow;
  const Button({
    this.label = "",
    this.width = double.infinity,
    required this.onPressed,
    this.color = Colors.white,
    this.bgColor = AppStyles.primaryColor,
    this.shadow = true,
    Key? key,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text(
          widget.label,
          style: TextStyle(color: widget.color),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            widget.width,
            40,
          ),
          primary: widget.bgColor,
          shadowColor:
              widget.shadow == false ? Colors.transparent : Colors.black,
        ),
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }
}
