import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/map_model.dart';
import 'package:vietnamcovidtracking/source/models/province_map_model.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';
part 'map_event.dart';
part 'map_state.dart';

Map<String, Color> mapColorByCount = {
  "1-100": ThemePrimary.primaryColor.withOpacity(0.1),
  "101 - 500": ThemePrimary.primaryColor.withOpacity(0.2),
  "501 - 1000": ThemePrimary.primaryColor.withOpacity(0.4),
  "1001 - 10000": ThemePrimary.primaryColor.withOpacity(0.6),
  "10001+": ThemePrimary.primaryColor
};

class MapBloc extends Bloc<MapEvent, MapState> {
  List<MapModelView> listMapModel = [];
  late MapShapeSource mapSource;

  late final List<MapColorMapper> _shapeColorMappers = <MapColorMapper>[
    MapColorMapper(
        from: 1,
        to: 100,
        color: ThemePrimary.primaryColor.withOpacity(0.2),
        text: '1-100'),
    MapColorMapper(
        from: 101,
        to: 500,
        color: ThemePrimary.primaryColor.withOpacity(0.4),
        text: '101 - 500'),
    MapColorMapper(
        from: 501,
        to: 1000,
        color: ThemePrimary.primaryColor.withOpacity(0.6),
        text: "501 - 1000"),
    MapColorMapper(
        from: 1001,
        to: 10000,
        color: ThemePrimary.primaryColor,
        text: '1001 - 10000'),
    MapColorMapper(
        from: 10001, to: 99999999999, color: Colors.red[300]!, text: '10001+'),
  ];

  MapBloc() : super(const MapState()) {
    on<LoadEvent>(onLoadData);
  }

  void onLoadData(LoadEvent event, Emitter<MapState> emit) async {
    emit(const LoadingState());
    // print("onLoadData");
    try {
      String data = await rootBundle.loadString('assets/vietnam.json');
      var jsonResult = json.decode(data);
      MapModelAsset _mapModel = MapModelAsset.fromJson(jsonResult);
      listMapModel = _mapModel.features.map((e) {
        return MapModelView(
            title: e.properties.name1,
            color: ThemePrimary.primaryColor,
            total: 0);
      }).toList();
      List<ProvinceMap> lstProvinceMap = await Api.getProvincesMap();
      await Future.forEach(lstProvinceMap, (ProvinceMap element) {
        if (element.data == null || element.data!.isEmpty) return;
        Color? _colors = mapColorByCount[element.name];
        List<String> _titleSet =
            element.data!.map((e) => e.title.toString()).toList();
        // Fix dữ liệu hcm bị null
        if (_titleSet.contains("")) {
          listMapModel
              .firstWhere((element) => element.title == "Hồ Chí Minh")
              .total = element.data!
                  .firstWhere((element) => element.title == "")
                  .confirmed ??
              0;
        }
        for (MapModelView mapModelView in listMapModel) {
          if (_titleSet.contains(mapModelView.title)) {
            mapModelView.color = _colors ?? ThemePrimary.primaryColor;
            mapModelView.total = element.data!
                    .firstWhere(
                        (element) => element.title == mapModelView.title)
                    .confirmed ??
                0;
          }
        }
      });
      mapSource = MapShapeSource.asset('assets/vietnam.json',
          shapeDataField: "NAME_1",
          dataCount: listMapModel.length,
          primaryValueMapper: (int index) => listMapModel[index].title,
          shapeColorValueMapper: (int index) =>
              listMapModel[index].total.toDouble(),
          shapeColorMappers: _shapeColorMappers);
    } catch (e) {}

    emit(const LoadingSucessState());
  }
}
