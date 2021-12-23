import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/chart_data.dart';

enum CovidNumberType { infections, beingtreated, gotcured, dead }

class StatisticsPage extends StatefulWidget {
  static const String routeName = "/statisticsPage";

  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<ChartData>? chartData;

  @override
  void initState() {
    chartData = <ChartData>[
      ChartData(x: "01/12", y: 81, secondSeriesYValue: 21),
      ChartData(x: "02/12", y: 52, secondSeriesYValue: 12),
      ChartData(x: "03/12", y: 64, secondSeriesYValue: 13),
      ChartData(x: "04/12", y: 80, secondSeriesYValue: 22),
      ChartData(x: "05/12", y: 140, secondSeriesYValue: 32),
      ChartData(x: "06/12", y: 90, secondSeriesYValue: 16),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _statistics() {
      Widget __statisticItem(
          {required Color backgroundColor, required String title}) {
        // Color _backgroundColor = ThemePrimary.green;
        double _currentRadius = 8;

        return Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    colors: [backgroundColor, backgroundColor.withOpacity(0.4)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topLeft),
                boxShadow: ThemePrimary.boxShadow,
                borderRadius: BorderRadius.circular(_currentRadius)),
            padding: const EdgeInsets.all(SizeApp.normalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  "1.588.335",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_upward,
                        size: 14.0, color: Colors.white),
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
                  __statisticItem(
                      title: "Số ca nhiễm", backgroundColor: ThemePrimary.red),
                  const SizedBox(width: SizeApp.paddingTxt),
                  __statisticItem(
                      title: "Đang điều trị",
                      backgroundColor: ThemePrimary.blue)
                ])),
            Container(
                margin: const EdgeInsets.only(top: SizeApp.paddingTxt),
                child: Row(children: [
                  __statisticItem(
                      title: "Đã khỏi bệnh",
                      backgroundColor: ThemePrimary.green),
                  const SizedBox(width: SizeApp.paddingTxt),
                  __statisticItem(
                      title: "Tử vong", backgroundColor: ThemePrimary.orange)
                ])),
            Container(
                padding: const EdgeInsets.all(SizeApp.paddingTxt),
                child: const Center(
                    child: Text("* Dữ liệu cập nhật tối ngày 26/10"))),
          ],
        ),
      );
    }

    Widget _chart() {
      SfCartesianChart _buildDefaultAreaChart() {
        List<ChartSeries<ChartData, dynamic>> _getDefaultAreaSeries() {
          return <ChartSeries<ChartData, dynamic>>[
            SplineAreaSeries<ChartData, dynamic>(
              onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
                return CustomSplineAreaSeriesRenderer(series);
              },
              gradient: LinearGradient(
                  colors: [ThemePrimary.red, ThemePrimary.red.withOpacity(0.2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              dataSource: chartData!,
              borderWidth: 2,
              opacity: 0.7,
              borderColor: ThemePrimary.red,
              borderDrawMode: BorderDrawMode.top,
              name: 'Ca nhiễm',
              xValueMapper: (ChartData sales, _) => sales.x,
              yValueMapper: (ChartData sales, _) => sales.y,
            ),
            SplineAreaSeries<ChartData, dynamic>(
              onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
                return CustomSplineAreaSeriesRenderer(series);
              },
              gradient: LinearGradient(colors: [
                ThemePrimary.orange,
                ThemePrimary.orange.withOpacity(0.2)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderWidth: 2,
              opacity: 0.7,
              borderColor: ThemePrimary.orange,
              borderDrawMode: BorderDrawMode.top,
              dataSource: chartData!,
              name: 'Tử vong',
              xValueMapper: (ChartData sales, _) => sales.x,
              yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
            )
          ];
        }

        return SfCartesianChart(
          legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              legendItemBuilder:
                  (String name, dynamic series, dynamic point, int index) {
                return SizedBox(
                    height: 24,
                    // width: 100,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          index != 0
                              ? Icon(Icons.remove,
                                  size: 16.0, color: ThemePrimary.orange)
                              : Icon(Icons.circle,
                                  size: 14.0, color: ThemePrimary.red),
                          SizedBox(width: 4.0),
                          Text(series.name,
                              style: Theme.of(context).textTheme.subtitle2!),
                          SizedBox(width: 4.0),
                        ]));
              },
              orientation: LegendItemOrientation.horizontal,
              alignment: ChartAlignment.near,
              position: LegendPosition.top),
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            majorGridLines: const MajorGridLines(width: 0),
            // edgeLabelPlacement: EdgeLabelPlacement.shift
          ),
          primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            // axisLine: const AxisLine(width: 0),
            // majorTickLines: const MajorTickLines(size: 0)
          ),
          series: _getDefaultAreaSeries(),
          tooltipBehavior: TooltipBehavior(enable: true),
        );
      }

      return Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: SizeApp.normalPadding),
          decoration: BoxDecoration(
              color: ThemePrimary.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(
            children: [
              Text("Biểu đồ số ca nhiễm và tử vong",
                  style: Theme.of(context).textTheme.headline2!),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Toàn quốc",
                      style: Theme.of(context).textTheme.bodyText1!),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              Expanded(
                child: _buildDefaultAreaChart(),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ThemePrimary.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_statistics(), _chart()],
      ),
      // ),
    );
  }
}
