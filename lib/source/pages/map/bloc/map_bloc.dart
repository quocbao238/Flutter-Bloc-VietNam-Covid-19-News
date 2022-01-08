// ignore_for_file: empty_catches

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/map_model.dart';
import 'package:vietnamcovidtracking/source/models/province_map_model.dart';
import 'package:vietnamcovidtracking/source/models/province_model.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  List<MapModelView> listMapModel = [];
  late MapShapeSource mapSource;
  List<Province> lstProvince = [];
  List<Province> lstSearchProvince = [];
  // bool isViewMap = true;

  // [danh sách vùng]
  Map<String, Color> mapColorByCount = {
    "1-100": ThemePrimary.primaryColor.withOpacity(0.1),
    "101 - 500": ThemePrimary.primaryColor.withOpacity(0.2),
    "501 - 1000": ThemePrimary.primaryColor.withOpacity(0.4),
    "1001 - 10000": ThemePrimary.primaryColor.withOpacity(0.6),
    "10001+": ThemePrimary.primaryColor
  };

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
    on<RefeshEvent>(onRefresh);
  }

  void onRefresh(RefeshEvent event, Emitter<MapState> emit) async {}

  void onLoadData(LoadEvent event, Emitter<MapState> emit) async {
    emit(const LoadingState());
    try {
      //start
      String data = await rootBundle.loadString('assets/vietnam.json');
      var jsonResult = json.decode(data);
      // List thứ nhất parse từ json local
      MapModelAsset _mapModel = MapModelAsset.fromJson(jsonResult);
      List<ProvinceMap> lstProvinceMap = await Api.getProvincesMap();
      // For list dữ liệu để map với listMapModel
      await Future.forEach(lstProvinceMap, (ProvinceMap element) {
        if (element.data == null || element.data!.isEmpty) return;
        Color? _colors = mapColorByCount[element.name];
        List<String> _titleSet =
            element.data!.map((e) => e.title.toString()).toList();
        for (var e in _mapModel.features) {
          if (_titleSet.contains(e.properties.name1)) {
            listMapModel.add(MapModelView(
                title: e.properties.name1,
                color: _colors ?? ThemePrimary.primaryColor,
                total: element.data!
                        .firstWhere(
                            (element) => element.title == e.properties.name1)
                        .confirmed ??
                    0));
          }
          if (_titleSet.contains("")) {
            listMapModel.add(MapModelView(
                title: "Hồ Chí Minh",
                color: _colors ?? ThemePrimary.primaryColor,
                total: element.data!
                        .firstWhere((element) => element.title == "")
                        .confirmed ??
                    0));
          }
        }
      });
    } catch (e) {}
    mapSource = MapShapeSource.asset('assets/vietnam.json',
        shapeDataField: "NAME_1",
        dataCount: listMapModel.length,
        primaryValueMapper: (int index) => listMapModel[index].title,
        shapeColorValueMapper: (int index) =>
            listMapModel[index].total.toDouble(),
        shapeColorMappers: _shapeColorMappers);

    emit(const LoadingSucessState());
  }

  // Future<void> onChangeMapListEvent(
  //     ChangeMapListEvent event, Emitter<MapState> emit) async {
  //   emit(const LoadingListData());
  //   // lstProvince.clear();
  //   lstSearchProvince.clear();
  //   isViewMap = event.isViewMap;
  //   if (lstProvince.isEmpty) {
  //     lstProvince = await Api.getAllPatientProvinces();
  //   }
  //   lstSearchProvince.addAll(lstProvince);
  //   emit(const LoadingSucessState());
  // }

  // void onSearchProvince(SearchProvinceEvent event, Emitter<MapState> emit) {
  //   emit(const SearchState());
  //   if (lstProvince.isEmpty) emit(const LoadingSucessState());
  //   String _keySearch = TiengViet.parse(event.keySearch).toLowerCase();
  //   lstSearchProvince.clear();
  //   if (_keySearch.isEmpty) {
  //     lstSearchProvince.addAll(lstProvince);
  //   } else {
  //     lstSearchProvince = lstProvince
  //         .where((element) => TiengViet.parse(element.title!)
  //             .toLowerCase()
  //             .contains(_keySearch))
  //         .toList();
  //   }
  //   emit(const LoadingSucessState());
  // }
}
