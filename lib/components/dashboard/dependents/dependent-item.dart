import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/models/dependent.dart';
import 'package:covid/providers/dataProvider.dart';
import 'package:covid/utils/functions.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DependentItem extends StatefulWidget {
  final DependentData data;
  final bool isVaccine;

  const DependentItem({
    required this.data,
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
    var names = widget.data.name.split(" ");
    shortName = "${names[0][0]}${names.length > 1 ? names[1][0] : ""}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                    value: widget.data.name,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    lineHeight: widget.isVaccine ? 1 : 1.3,
                  ),
                  TextBox(
                    value: widget.data.relation,
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
                  onPressed: () {
                    if (!widget.isVaccine) {
                      removeDependent(widget.data.id);
                    }
                  },
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

  void removeDependent(String dependentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("dependent")
          .doc(dependentId)
          .delete();
      List<DependentData> dependents =
          Provider.of<DataProvider>(context, listen: false).getDependents;
      dependents.removeWhere((element) => (element.id == dependentId));
      Provider.of<DataProvider>(context, listen: false).setDependents =
          dependents;
    } catch (e) {
      showToast("Can't delete dependent");
      print(e);
    }
  }
}
