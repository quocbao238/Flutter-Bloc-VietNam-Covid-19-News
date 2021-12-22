import 'package:flutter/material.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';

enum CovidNumberType { infections, beingtreated, gotcured, dead }

class StatisticsPage extends StatefulWidget {
  static const String routeName = "/statisticsPage";

  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        padding: const EdgeInsets.only(
            left: SizeApp.normalPadding,
            right: SizeApp.normalPadding,
            bottom: SizeApp.normalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Số liệu thống kê trong nước",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white)),
            Container(
                margin: const EdgeInsets.only(top: SizeApp.normalPadding),
                child: Row(children: [
                  __statisticItem(backgroundColor: ThemePrimary.green),
                  const SizedBox(width: SizeApp.paddingTxt),
                  __statisticItem(backgroundColor: ThemePrimary.green)
                ])),
            Container(
                margin: const EdgeInsets.only(top: SizeApp.paddingTxt),
                child: Row(children: [
                  __statisticItem(backgroundColor: ThemePrimary.green),
                  const SizedBox(width: SizeApp.paddingTxt),
                  __statisticItem(backgroundColor: ThemePrimary.green)
                ])),
            Container(
                padding: const EdgeInsets.all(SizeApp.paddingTxt),
                child: const Center(
                    child: Text("* Dữ liệu cập nhật tối ngày 26/10"))),
            Text("Biểu đồ số ca nhiễm và tử vong",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white)),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: ThemePrimary.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(),
        ],
      ),
    );
  }

  Widget __statisticItem({required Color backgroundColor}) {
    // Color _backgroundColor = ThemePrimary.green;
    double _currentRadius = 8;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: ThemePrimary.boxShadow,
            borderRadius: BorderRadius.circular(_currentRadius)),
        padding: const EdgeInsets.all(SizeApp.normalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Số ca nhiễm",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
            ),
            Text(
              "1.588.335",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_upward),
                Text(
                  "16.555",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
