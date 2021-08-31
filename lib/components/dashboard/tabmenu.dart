import 'package:covid/components/dashboard/news.dart';
import 'package:covid/components/dashboard/things-to-do.dart';
import 'package:flutter/material.dart';

class TabMenu extends StatefulWidget {
  const TabMenu({Key? key}) : super(key: key);

  @override
  _TabMenuState createState() => _TabMenuState();
}

class _TabMenuState extends State<TabMenu> with TickerProviderStateMixin {
  late TabController _tabController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.red,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            unselectedLabelColor: Colors.black45,
            tabs: [
              Tab(text: "Things to know"),
              Tab(text: "Things to do"),
            ],
            onTap: (selectedTab) {
              setState(() {
                currentPage = selectedTab;
              });
            },
          ),
        ),
        currentPage == 0 ? NewsPage() : ThingsToDoPage(),
      ],
    );
  }
}
