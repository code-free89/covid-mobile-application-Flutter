import 'package:covid/components/textbox.dart';
import 'package:covid/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatefulWidget {
  final Map<String, dynamic> news;
  const NewsCard({required this.news, Key? key}) : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage("assets/images/img2.png"),
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBox(
                          value: "CPRC KKM",
                          fontSize: 14,
                          lineHeight: 1.2,
                        ),
                        TextBox(
                          value: widget.news["date"].toString(),
                          fontSize: 12,
                          fontColor: Colors.black26,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                TextBox(
                  value: widget.news["title"],
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.black54,
                  fontSize: 14,
                  padding: 10,
                ),
                widget.news["link"] == true
                    ? Row(
                        children: [
                          TextBox(
                            value: "Ikuti kami di : ",
                            fontSize: 14,
                            fontColor: Colors.black54,
                          ),
                          InkWell(
                            child: TextBox(
                              value: "http://www.infosihat.gov.my",
                              fontColor: AppStyles.primaryColor,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                            onTap: () {
                              launch("http://www.infosihat.gov.my");
                            },
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          Image(
            image: NetworkImage(widget.news["image"]),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
