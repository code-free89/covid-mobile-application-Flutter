import 'package:covid/components/textbox.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DependentItem extends StatefulWidget {
  final String name;
  final String relation;
  final bool isVaccine;
  const DependentItem({
    this.name = "",
    this.relation = "",
    this.isVaccine = false,
    Key? key,
  }) : super(key: key);

  @override
  _DependentItemState createState() => _DependentItemState();
}

class _DependentItemState extends State<DependentItem> {
  String shortName = "";
  @override
  void initState() {
    var names = widget.name.split(" ");
    shortName = "${names[0][0]}${names.length > 1 ? names[1][0] : ""}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF7F7F7),
                  border: Border.all(color: Colors.black12),
                ),
                padding: EdgeInsets.all(8),
                child: Center(
                  child: TextBox(
                    value: shortName,
                    fontWeight: FontWeight.w500,
                    fontColor: AppStyles.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox(
                    value: widget.name,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    lineHeight: widget.isVaccine ? 1 : 1.3,
                  ),
                  TextBox(
                    value: widget.relation,
                    fontSize: 12,
                    fontColor: Colors.black54,
                  ),
                  widget.isVaccine
                      ? TextBox(
                          value: "Remove from vaccine",
                          fontColor: Colors.blueAccent[700] ?? Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )
                      : Container(),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 15,
                height: 15,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    size: 15,
                  ),
                  padding: EdgeInsets.all(0),
                ),
              ),
              SizedBox(width: 15),
              SizedBox(
                width: 15,
                height: 15,
                child: IconButton(
                  onPressed: () {},
                  icon: widget.isVaccine
                      ? SvgPicture.asset(
                          "assets/images/green.svg",
                          width: 20,
                          height: 20,
                        )
                      : Icon(
                          Icons.close,
                          size: 15,
                        ),
                  padding: EdgeInsets.all(0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
