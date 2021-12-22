import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  static const String routeName = "/statisticsPage";

  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("StatisticsPage"));
  }
}
