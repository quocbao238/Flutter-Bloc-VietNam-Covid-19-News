// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/map_model.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';

class MapPage extends StatefulWidget {
  static const String routeName = "/mapPage";
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late List<ModelMap> _data;
  late MapShapeSource _mapSource;

  @override
  void initState() {
    // _data = const <Model>[
    //   Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
    //       '       New\nSouth Wales'),
    //   Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
    //   Model('Northern Territory', Color.fromRGBO(255, 78, 66, 1.0),
    //       'Northern\nTerritory'),
    //   Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
    //   Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
    //       'South Australia'),
    //   Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
    //       'Western Australia'),
    //   Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
    //   Model('Australian Capital Territory', Colors.teal, 'ACT')
    // ];
    _mapSource = MapShapeSource.asset(
      'assets/vietnam.json',
      dataCount: listFeature.length,
    );

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await loadJson();
      var a = await Api.getSummPatient();
      print(a);
    });
  }

  List<Feature> listFeature = [];

  loadJson() async {
    String data = await rootBundle.loadString('assets/vietnam.json');
    var jsonResult = json.decode(data);

    MapModel mapModel = MapModel.fromJson(jsonResult);
    listFeature = mapModel.features;
    // print(listFeature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemePrimary.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                left: SizeApp.normalPadding,
                right: SizeApp.normalPadding,
                bottom: SizeApp.normalPadding),
            child: Text("Bản đồ vùng dịch",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    overflow: TextOverflow.ellipsis, color: Colors.white)),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: ThemePrimary.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SfMaps(layers: [
                          MapShapeLayer(
                            source: _mapSource,
                            legend: const MapLegend(MapElement.shape),
                            tooltipSettings: MapTooltipSettings(
                                color: Colors.grey[700],
                                strokeColor: Colors.white,
                                strokeWidth: 2),
                            strokeColor: Colors.white,
                            strokeWidth: 0.5,
                            shapeTooltipBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _data[index].stateCode,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            },
                            dataLabelSettings: MapDataLabelSettings(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .fontSize)),
                          ),
                        ]),
                      ),
                    ])),
          ),
        ],
      ),
      // ),
    );
  }
}
