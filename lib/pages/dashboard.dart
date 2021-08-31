import 'package:covid/components/textbox.dart';
import 'package:covid/constants/dashboard-menu.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isScrolled = false;
  final ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                "MySejahtera",
                style: TextStyle(fontSize: 30),
              )
            : Center(
                child: Text("MySejahtera"),
              ),
        leading: Container(),
        leadingWidth: 0,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: AppStyles.primaryColor,
                ),
                height: 150,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Card(
                    child: GridView.count(
                      crossAxisCount: 3,
                      padding: EdgeInsets.only(
                        top: 15,
                        left: 15,
                        bottom: 0,
                        right: 15,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 1.3,
                      children: dashboardMenus
                          .map(
                            (dashboardMenu) => Column(
                              children: [
                                dashboardMenu["icon"],
                                SizedBox(height: 5),
                                TextBox(
                                  value: dashboardMenu["title"],
                                  textAlign: TextAlign.center,
                                  fontSize: 12,
                                  fontColor: Colors.black54,
                                  lineHeight: 1.3,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
