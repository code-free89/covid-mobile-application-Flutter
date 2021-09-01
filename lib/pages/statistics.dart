import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool _isScrolled = false;
  final ScrollController _scrollController = new ScrollController();

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
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppStyles.primaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Row(
                      children: [],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  height: 150,
                ),
              ),
              Container(
                height: 400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
