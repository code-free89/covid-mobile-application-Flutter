import 'package:covid/components/textbox.dart';
import 'package:covid/models/checkin-history.dart';
import 'package:covid/pages/checkin/history-item.dart';
import 'package:covid/providers/dataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckInHistoryPage extends StatefulWidget {
  const CheckInHistoryPage({Key? key}) : super(key: key);

  @override
  _CheckInHistoryPageState createState() => _CheckInHistoryPageState();
}

class _CheckInHistoryPageState extends State<CheckInHistoryPage> {
  @override
  Widget build(BuildContext context) {
    List<CheckInHistoryData> histories =
        Provider.of<DataProvider>(context, listen: true).getHistories;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: InkWell(
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        title: Text("History"),
        actions: <Widget>[
          new Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                color: Colors.teal[100],
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextBox(
                        value:
                            "Your check-in history will be removed if you logout or reinstall the application",
                        fontSize: 12,
                        lineHeight: 1.3,
                        fontStyle: FontStyle.italic,
                        fontColor: Colors.teal[900] ?? Colors.teal,
                      ),
                      SizedBox(height: 5),
                      TextBox(
                        value:
                            "Check-out details will be displyed here. If you have not checked out, you can click on a past check-in to check-out accordingly",
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        lineHeight: 1.3,
                        fontColor: Colors.teal[900] ?? Colors.teal,
                      ),
                    ],
                  ),
                ),
              ),
              ...histories
                  .map((history) => CheckInHistoryItem(history: history))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
