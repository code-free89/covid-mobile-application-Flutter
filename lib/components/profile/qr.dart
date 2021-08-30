import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

class QRWidget extends StatefulWidget {
  final Function onTap;
  const QRWidget({required this.onTap, Key? key}) : super(key: key);

  @override
  _QRWidgetState createState() => _QRWidgetState();
}

class _QRWidgetState extends State<QRWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(false),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Image(
              image: AssetImage("assets/images/qr-medium.png"),
              width: 200,
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                TextBox(
                  value: "Back",
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.black26,
                )
              ],
            ),
          ),
          onTap: () {
            widget.onTap();
          },
        )
      ],
    );
  }
}
