import 'package:covid/components/textbox.dart';
import 'package:covid/constants/vaccinationStatus.dart';
import 'package:covid/pages/home.dart';
import 'package:covid/pages/profile.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

class VaccinationStatus extends StatefulWidget {
  const VaccinationStatus({Key? key}) : super(key: key);

  @override
  _VaccinationStatusState createState() => _VaccinationStatusState();
}

class _VaccinationStatusState extends State<VaccinationStatus> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = getUserData(context);
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 550,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBox(
                value: "Name",
                fontSize: 14,
                fontColor: Colors.black38,
                padding: 7,
              ),
              TextBox(
                value: userData["name"].toString().toUpperCase(),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                padding: 7,
              ),
              TextBox(
                value: "IC/Passport No",
                fontSize: 14,
                fontColor: Colors.black38,
                padding: 8,
              ),
              TextBox(
                value: userData["passportNo"],
                fontSize: 20,
                fontWeight: FontWeight.w500,
                padding: 5,
              ),
              Expanded(
                child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: .2,
                    connectorTheme: ConnectorThemeData(
                      thickness: .5,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    indicatorBuilder: (context, index) {
                      return DotIndicator(
                        color: Colors.green[100],
                        size: 20,
                        child: index != vaccinationSteps.length - 1
                            ? SvgPicture.asset(
                                "assets/images/green.svg",
                                width: 20,
                                height: 20,
                              )
                            : SvgPicture.asset(
                                "assets/images/home/vaccineTrue.svg",
                                width: 20,
                                height: 20,
                              ),
                      );
                    },
                    connectorBuilder: (_, index, connectorType) {
                      return SolidLineConnector(
                        indent: connectorType == ConnectorType.start ? 0 : 2.0,
                        endIndent: connectorType == ConnectorType.end ? 0 : 2.0,
                        color: Colors.grey[700],
                      );
                    },
                    oppositeContentsBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(top: 5, right: 10),
                      child: TextBox(
                        value: vaccinationSteps[index]["date"],
                        fontSize: 13,
                        fontColor: Colors.black87,
                      ),
                    ),
                    // contentsAlign: ContentsAlign.basic,
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 18, bottom: 15),
                      child: TextBox(
                        value: vaccinationSteps[index]["value"],
                        fontSize: 15,
                        fontWeight: index == vaccinationSteps.length - 1
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                    ),
                    itemCount: vaccinationSteps.length,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 200,
                  child: GestureDetector(
                    child: TextBox(
                      value:
                          "Click here to view your COVID-19 vaccination digital certificate",
                      fontSize: 13,
                      fontColor: Color(0xFF0000FF),
                      decoration: TextDecoration.underline,
                      lineHeight: 1.2,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            initialPage: 3,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
