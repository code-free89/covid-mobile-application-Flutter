import 'package:covid/components/button.dart';
import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';

class StatisticCard extends StatefulWidget {
  final String cardType;
  final Color color;
  final Color bgColor;
  final String title;
  final String date;
  final double value;
  final String imgSrc;
  final int todayValue;
  const StatisticCard(
      {required this.cardType,
      required this.color,
      required this.bgColor,
      required this.title,
      required this.date,
      required this.value,
      this.imgSrc = "",
      this.todayValue = 0,
      Key? key})
      : super(key: key);

  @override
  _StatisticCardState createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Card(
        color: widget.cardType == "image" ? Colors.white : widget.bgColor,
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          // decoration: BoxDecoration(color: widget.bgColor),
          child: Column(
            children: [
              TextBox(
                value: widget.title,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                padding: 10,
                fontColor:
                    widget.cardType == "image" ? Colors.black : Colors.white,
                textAlign: TextAlign.center,
                lineHeight: 1.2,
              ),
              TextBox(
                value: "setakat ${widget.date}",
                fontColor:
                    widget.cardType == "image" ? Colors.black26 : Colors.white,
                fontSize: 13,
              ),
              SizedBox(height: 30),
              widget.cardType == "image"
                  ? widget.imgSrc != ""
                      ? Image(
                          image: NetworkImage(widget.imgSrc),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        )
                      : Container()
                  : TextBox(
                      value: widget.cardType == "decimal"
                          ? widget.value.toString()
                          : widget.value.round().toString().replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},'),
                      fontSize: 40,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              SizedBox(height: 35),
              widget.cardType != "image"
                  ? Container(
                      height: 40,
                      child: widget.cardType == "integer"
                          ? Button(
                              onPressed: () {},
                              label: "+ ${widget.todayValue} Hari Ini (Today)",
                              color: widget.color,
                              bgColor: Colors.white,
                            )
                          : Container(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
