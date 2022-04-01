import 'package:covid/components/textbox.dart';
import 'package:covid/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ConfirmationCard extends StatefulWidget {
  const ConfirmationCard({Key? key}) : super(key: key);

  @override
  _ConfirmationCardState createState() => _ConfirmationCardState();
}

class _ConfirmationCardState extends State<ConfirmationCard> {
  @override
  Widget build(BuildContext context) {
    String refreshDate = Provider.of<AuthProvider>(context, listen: true)
        .currentDateTime
        .substring(6);
    DateTime formattedDate =
        DateFormat('dd MMM yyyy, hh:mm aaa').parse(refreshDate);
    String confirmDate = DateFormat('dd/MM/yyyy').format(formattedDate);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(112, 173, 70, 1),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextBox(
                  value: 'COVID-19 Negative',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontColor: Color.fromRGBO(112, 173, 70, 1),
                ),
              ),
              Image.asset(
                'assets/images/mosti.png',
                width: 60,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBox(
                value: 'Confirmation date: ' + confirmDate,
                fontSize: 12,
                fontColor: Colors.white,
              ),
              TextBox(
                value: 'RT-PCR',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontColor: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextBox(
                value: 'Source: MKAK, KKM',
                fontSize: 12,
                fontColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
