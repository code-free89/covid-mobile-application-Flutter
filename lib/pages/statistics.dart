import 'package:covid/components/statistics/global.dart';
import 'package:covid/components/statistics/states.dart';
import 'package:covid/components/statistics/tabmenu.dart';
import 'package:covid/components/statistics/update.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool _isScrolled = false;
  int currentIndex = 0;
  final ScrollController _scrollController = new ScrollController();
  List<Widget> _tabs = [
    StatisticUpdate(),
    StatisticsStates(),
    StatisticsGlobal(),
  ];

  @override
  void initState() {
    _scrollController.addListener(() {
      double curPos = _scrollController.position.pixels;
      setState(() {
        _isScrolled = curPos > 150 ? true : false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42,
        backgroundColor: AppStyles.primaryColor,
        title: !_isScrolled
            ? Text(
                "Statistics",
                style: TextStyle(fontSize: 30),
              )
            : Center(
                child: Text("Statistics"),
              ),
        leading: Container(),
        leadingWidth: 0,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppStyles.primaryColor,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          StatisticTab(
                            index: 0,
                            value: "COVID-19 Update",
                            currentIndex: currentIndex,
                            onTap: () {
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                          ),
                          StatisticTab(
                            index: 1,
                            value: "COVID-19 States",
                            currentIndex: currentIndex,
                            onTap: () {
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                          ),
                          StatisticTab(
                            index: 2,
                            value: "COVID-19 Global Update",
                            currentIndex: currentIndex,
                            onTap: () {
                              setState(() {
                                currentIndex = 2;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppStyles.primaryColor,
                  ),
                  height: 150,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 80,
                  left: 10,
                  bottom: 10,
                  right: 10,
                ),
                child: _tabs[currentIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
