import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  static const String routeName = "/newsPage";

  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("NewsPage"));
  }
}
