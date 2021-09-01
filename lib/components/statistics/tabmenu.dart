import 'package:covid/components/textbox.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';

class StatisticTab extends StatefulWidget {
  final int index;
  final int currentIndex;
  final String value;
  final Function onTap;
  const StatisticTab(
      {required this.index,
      this.currentIndex = 0,
      required this.value,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  _StatisticTabState createState() => _StatisticTabState();
}

class _StatisticTabState extends State<StatisticTab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: widget.index == widget.currentIndex
              ? Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        padding: EdgeInsets.only(top: 10, left: 15, bottom: 5, right: 15),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: TextBox(
              value: widget.value,
              fontColor: widget.index == widget.currentIndex
                  ? AppStyles.primaryColor
                  : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
      ),
      onTap: () {
        widget.onTap();
      },
    );
  }
}
