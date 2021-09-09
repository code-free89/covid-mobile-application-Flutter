import 'package:covid/components/statistics/statistic-card.dart';
import 'package:covid/utils/functions.dart';
import 'package:flutter/material.dart';

class StatisticUpdate extends StatefulWidget {
  const StatisticUpdate({Key? key}) : super(key: key);

  @override
  _StatisticUpdateState createState() => _StatisticUpdateState();
}

class _StatisticUpdateState extends State<StatisticUpdate> {
  Map<String, dynamic> updateData = {};
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(updateData);
    return updateData.isNotEmpty
        ? Column(
            children: [
              StatisticCard(
                cardType: "decimal",
                color: Color(0xFF0032F4),
                bgColor: Color(0xFF0032F4),
                title: "Nilai R (R Value)",
                date: updateData["date"],
                value: double.parse(updateData["rValue"].toString()),
              ),
              StatisticCard(
                cardType: "integer",
                color: Color(0xFFFD0022),
                bgColor: Color(0xFFFD0022),
                title: "Jumlah Kes Keseluruhan (Total Confirmed Cases)",
                date: updateData["date"],
                value: double.parse(updateData["confirmCase"].toString()),
                todayValue:
                    int.parse(updateData["todayConfirmCases"].toString()),
              ),
              StatisticCard(
                cardType: "integer",
                color: Color(0xFF14BA1C),
                bgColor: Color(0xFF14BA1C),
                title: "Jumlah Kes Sembuh (Total Recoverd)",
                date: updateData["date"],
                value: double.parse(updateData["recovered"].toString()),
                todayValue: int.parse(updateData["todayRecovered"].toString()),
              ),
              StatisticCard(
                cardType: "integer",
                color: Color(0xFFFF0022),
                bgColor: Colors.black,
                title: "Jumlah Kematian (Total Death)",
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
                value: double.parse(updateData["activeCase"].toString()),
                todayValue:
                    int.parse(updateData["todayActiveCases"].toString()),
              ),
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Statistik Migguan (Weekly Statistics)",
                date: updateData["date"],
                value: double.parse(updateData["activeCase"].toString()),
                todayValue:
                    int.parse(updateData["todayActiveCases"].toString()),
                imgSrc: updateData["weeklyStatistics"],
              ),
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Trend Kes Aktif (Active Cases Trend)",
                date: updateData["date"],
                value: double.parse(updateData["activeCase"].toString()),
                todayValue:
                    int.parse(updateData["todayActiveCases"].toString()),
                imgSrc: updateData["activeCaseTrend"],
              ),
              StatisticCard(
                cardType: "image",
                color: Color(0xFFFF0022),
                bgColor: Color(0xFFFF9300),
                title: "Trend Mingguan COVID-19 (Weekly trend of COVID-19)",
                date: updateData["date"],
                value: double.parse(updateData["activeCase"].toString()),
                todayValue:
                    int.parse(updateData["todayActiveCases"].toString()),
                imgSrc: updateData["weeklyTrend"],
              ),
            ],
          )
        : Container();
  }

  void getData() async {
    Map<String, dynamic> data = await getStatisticsUpdate();
    setState(() {
      updateData = data;
    });
  }
}
