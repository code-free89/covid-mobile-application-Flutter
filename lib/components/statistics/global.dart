import 'package:covid/components/statistics/statistic-card.dart';
import 'package:covid/utils/functions.dart';
import 'package:flutter/material.dart';

class StatisticsGlobal extends StatefulWidget {
  const StatisticsGlobal({Key? key}) : super(key: key);

  @override
  _StatisticsGlobalState createState() => _StatisticsGlobalState();
}

class _StatisticsGlobalState extends State<StatisticsGlobal> {
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
                cardType: "integer",
                color: Color(0xFFFD0022),
                bgColor: Color(0xFFFD0022),
                title: "Kes Keseluruhan Dunia (World Confirmed Cases)",
                date: updateData["date"],
                value: double.parse(updateData["confirmedCases"].toString()),
                todayValue:
                    int.parse(updateData["todayConfirmedCases"].toString()),
              ),
              StatisticCard(
                cardType: "integer",
                color: Color(0xFF14BA1C),
                bgColor: Color(0xFF14BA1C),
                title: "Kes Sembuh Dunia (World Recoverd Cases)",
                date: updateData["date"],
                value: double.parse(updateData["recoveredCases"].toString()),
                todayValue:
                    int.parse(updateData["todayRecoveredCases"].toString()),
              ),
              StatisticCard(
                cardType: "integer",
                color: Color(0xFFFF0022),
                bgColor: Colors.black,
                title: "Kes Kematian Dunia (World Deaths)",
                date: updateData["date"],
                value: double.parse(updateData["death"].toString()),
                todayValue: int.parse(updateData["todayDeath"].toString()),
              ),
              StatisticCard(
                cardType: "integer",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Kes Aktif (Active Cases)",
                date: updateData["date"],
                value: double.parse(updateData["activeCases"].toString()),
                todayValue:
                    int.parse(updateData["todayActiveCases"].toString()),
              ),
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Negara dengan Kes Tertinggi (Top 10 Countries)",
                date: updateData["date"],
                value: 0,
                todayValue: 0,
                imgSrc: updateData["topCountries"],
              ),
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Statistik ASEAN (ASEAN Statistics)",
                date: updateData["date"],
                value: 0,
                todayValue: 0,
                imgSrc: updateData["aseanStatistics"],
              ),
            ],
          )
        : Container();
  }

  void getData() async {
    Map<String, dynamic> data = await getStatisticsGlobal();
    setState(() {
      updateData = data;
    });
  }
}
