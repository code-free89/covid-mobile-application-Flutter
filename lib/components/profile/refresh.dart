import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

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
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cached_outlined,
                  size: 28,
                ),
                SizedBox(width: 15),
                TextBox(
                  value: "Click to refresh your profile",
                  fontColor: Colors.black87,
                  fontSize: 14,
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
    );
  }
}
