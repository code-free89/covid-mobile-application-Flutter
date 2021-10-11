import 'package:covid/components/textbox.dart';
import 'package:covid/models/checkin-history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckInHistoryItem extends StatefulWidget {
  final CheckInHistoryData history;
  const CheckInHistoryItem({required this.history, Key? key}) : super(key: key);

  @override
  _CheckInHistoryItemState createState() => _CheckInHistoryItemState();
}

class _CheckInHistoryItemState extends State<CheckInHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/images/checkin/history.svg",
              width: 40,
              height: 40,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox(
                    value:
                        "Check-out at ${widget.history.location.replaceAll("_", " ")}",
                    fontSize: 14,
                    lineHeight: 1.1,
                  ),
                  TextBox(
                    value: widget.history.date,
                    fontSize: 12,
                    fontColor: Colors.black45,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
