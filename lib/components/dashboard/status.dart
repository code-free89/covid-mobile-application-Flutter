import 'package:covid/components/textbox.dart';
import 'package:covid/constants/dashboard-menu.dart';
import 'package:flutter/material.dart';

class DashboardStatusCard extends StatefulWidget {
  const DashboardStatusCard({Key? key}) : super(key: key);

  @override
  _DashboardStatusCardState createState() => _DashboardStatusCardState();
}

class _DashboardStatusCardState extends State<DashboardStatusCard> {
  List<Function> functions = [
    (BuildContext context) {
      Navigator.pushNamed(context, "/status");
    },
    (BuildContext context) {
      Navigator.pushNamed(context, "/vaccination");
    },
    (BuildContext context) {},
    (BuildContext context) {},
    (BuildContext context) {},
    (BuildContext context) {},
    (BuildContext context) {
      Navigator.pushNamed(context, "/dependents");
    },
    (BuildContext context) {},
    (BuildContext context) {}
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
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
        childAspectRatio: 1.4,
        children: dashboardMenus
            .asMap()
            .map(
              (index, dashboardMenu) => MapEntry(
                index,
                InkWell(
                  child: Column(
                    children: [
                      dashboardMenu["icon"],
                      SizedBox(height: 4),
                      TextBox(
                        value: dashboardMenu["title"],
                        textAlign: TextAlign.center,
                        fontSize: 12,
                        fontColor: Colors.black54,
                        lineHeight: 1.3,
                      ),
                    ],
                  ),
                  onTap: () {
                    functions[index](context);
                  },
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
