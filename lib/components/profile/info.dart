import 'package:covid/components/textbox.dart';
import 'package:covid/utils/functions.dart';
import 'package:flutter/material.dart';

class InformationCard extends StatefulWidget {
  const InformationCard({Key? key}) : super(key: key);

  @override
  _InformationCardState createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBox(
                  value: "MySJ ID",
                  fontSize: 15,
                ),
                TextBox(
                  value: userData["phoneNumber"] != ""
                      ? userData["phoneNumber"].toString().substring(1)
                      : userData["email"],
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                )
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBox(
                  value: "IC / Passport No",
                  fontSize: 15,
                ),
                TextBox(
                  value: userData["passportNo"] != ""
                      ? userData["passportNo"]
                      : "",
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                )
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBox(
                  value: "State",
                  fontSize: 15,
                ),
                TextBox(
                  value: userData["state"] != "" ? userData["state"] : "",
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
