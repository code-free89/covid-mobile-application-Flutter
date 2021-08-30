import 'package:covid/components/textbox.dart';
import 'package:covid/models/user.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';

class NameCard extends StatefulWidget {
  final String name;
  const NameCard({this.name = "", Key? key}) : super(key: key);

  @override
  _NameCardState createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  late var userData;
  @override
  void initState() {
    userData = getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF7F7F7),
                border: Border.all(color: Colors.black12),
              ),
              padding: EdgeInsets.all(8),
              child: Center(
                child: TextBox(
                  value: widget.name,
                  fontWeight: FontWeight.w500,
                  fontColor: AppStyles.primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBox(
                  value: userData["name"].toString().toUpperCase(),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                TextBox(
                  value: "Low Risk No Symptom",
                  fontSize: 14,
                  fontColor: Colors.black87,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
