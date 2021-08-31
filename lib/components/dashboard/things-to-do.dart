import 'package:covid/components/textbox.dart';
import 'package:covid/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThingsToDoPage extends StatefulWidget {
  const ThingsToDoPage({Key? key}) : super(key: key);

  @override
  _ThingsToDoPageState createState() => _ThingsToDoPageState();
}

class _ThingsToDoPageState extends State<ThingsToDoPage> {
  late Map<String, dynamic> userData;
  @override
  void initState() {
    userData = getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/images/home/noCards.svg",
              width: 90,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextBox(value: "Hi, ", fontSize: 16),
                TextBox(
                  value: userData["name"],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: 10),
            TextBox(
              value:
                  "You have no pending tasks, thank you for your cooperation.",
              fontColor: Colors.black26,
              fontSize: 12,
            )
          ],
        ),
      ),
    );
  }
}
