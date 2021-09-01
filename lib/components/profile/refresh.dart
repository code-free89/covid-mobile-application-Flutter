import 'package:covid/components/textbox.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RefreshCard extends StatefulWidget {
  const RefreshCard({Key? key}) : super(key: key);

  @override
  _RefreshCardState createState() => _RefreshCardState();
}

class _RefreshCardState extends State<RefreshCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/refresh.svg",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 15),
                  TextBox(
                    value: "Click to refresh your profile",
                    fontColor: Colors.black87,
                    fontSize: 15,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black12,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: TextBox(
                  value: "Refresh",
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          DateTime now = DateTime.now();
          String formattedDate =
              DateFormat('dd MMM yyyy,').add_jm().format(now);
          Provider.of<AuthProvider>(context, listen: false).currentDateTime =
              "As of $formattedDate";
        },
      ),
    );
  }
}
