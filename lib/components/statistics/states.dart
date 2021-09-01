import 'package:covid/components/statistics/statistic-card.dart';
import 'package:covid/utils/functions.dart';
import 'package:flutter/material.dart';

class StatisticsStates extends StatefulWidget {
  const StatisticsStates({Key? key}) : super(key: key);

  @override
  _StatisticsStatesState createState() => _StatisticsStatesState();
}

class _StatisticsStatesState extends State<StatisticsStates> {
  Map<String, dynamic> updateData = {};
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return updateData.isNotEmpty
        ? Column(
            children: [
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Kes Mengikut Negeri (Cases by States)",
                date: updateData["date"],
                value: 0,
                todayValue: 0,
                imgSrc: updateData["caseStates"],
              ),
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Kes Semenanjung Malaysia (Cases in West Malaysia)",
                date: updateData["date"],
                value: 0,
                todayValue: 0,
                imgSrc: updateData["caseInWest"],
              ),
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Kes Malaysia Timur (Cases in East Malaysia)",
                date: updateData["date"],
                value: 0,
                todayValue: 0,
                imgSrc: updateData["caseInEast"],
              ),
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Jumlah Keseluruhan Taburan Kes (Cases Overview)",
                date: updateData["date"],
                value: 0,
                todayValue: 0,
                imgSrc: updateData["caseOverview"],
              ),
            ],
          )
        : Container();
  }

  void getData() async {
    Map<String, dynamic> data = await getStatisticsStates();
    setState(() {
      updateData = data;
    });
  }
}
