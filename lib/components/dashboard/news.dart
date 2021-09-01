import 'package:covid/components/dashboard/newscard.dart';
import 'package:covid/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Map<String, dynamic>> newsData = [];
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) getNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: newsData.length > 0
          ? newsData.map((news) => NewsCard(news: news)).toList()
          : [],
    );
  }

  void getNewsData() async {
    List<Map<String, dynamic>> news = await getNews();
    setState(() {
      newsData = news;
    });
  }
}
