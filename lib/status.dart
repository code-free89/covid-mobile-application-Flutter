import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

import 'components/button.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leadingWidth: 0,
        leading: Container(),
        shadowColor: Colors.transparent,
        title: Center(
          child: Text("Status"),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 25, right: 25, top: 120, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.fitWidth,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextBox(
                        value:
                            "Submit your Health Declaration Form for COVID- 19 by clicking Start button below",
                        fontSize: 15,
                        padding: 15,
                      ),
                      TextBox(
                        value:
                            "Sila hantar Borang Akuan Kesihatan untuk COVID- 19 dengan menekan butang Mula di bawah",
                        fontSize: 15,
                        padding: 130,
                      ),
                    ],
                  ),
                ),
                Button(
                  onPressed: () {
                    Navigator.pushNamed(context, "/question");
                  },
                  label: "Start",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
