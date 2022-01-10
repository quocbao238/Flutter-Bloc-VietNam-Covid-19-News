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
    on<WarningMapEvent>(onWarningMap);
  }

  void onRefresh(RefeshEvent event, Emitter<MapState> emit) async {}

  void onLoadData(LoadEvent event, Emitter<MapState> emit) async {
    emit(const LoadingState());
    try {
      //start
      String data = await rootBundle.loadString('assets/maps/vietnam.json');
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
      mapSource = MapShapeSource.asset('assets/maps/vietnam.json',
          shapeDataField: "NAME_1",
          dataCount: listMapModel.length,
          primaryValueMapper: (int index) => listMapModel[index].title,
          shapeColorValueMapper: (int index) =>
              listMapModel[index].total.toDouble(),
          shapeColorMappers: _shapeColorMappers);
    } catch (e) {
      mapSource = const MapShapeSource.asset('assets/maps/vietnam.json',
          shapeDataField: "NAME_1");
    }

    emit(const LoadingSucessState());
  }

  onWarningMap(WarningMapEvent event, Emitter<MapState> emit) async {
    showDialog(
        context: event.context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 32, right: 8),
              child: Stack(
                // ignore: deprecated_member_use
                overflow: Overflow.visible,
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(right: 24.0, top: 40),
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Thông báo",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: ThemePrimary.primaryColor)),
                          const SizedBox(height: 8.0),
                          Text(
                              "Vì mục đích chính là hiển thị thông tin số liệu ca nhiễm các tỉnh thành trên cả nước nên sẽ không hiển thị các \"Hải Đảo\" trên bản đồ.Mong các bạn thông cảm!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1!),
                        ],
                      )),
                  Positioned(
                      top: 0,
                      child: Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ThemePrimary.primaryColor),
                          child: const Center(
                              child: Icon(
                            Icons.warning,
                            color: Colors.white,
                            size: 34,
                          )))),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Ink(
                          padding: const EdgeInsets.all(4.0),
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: const Icon(Icons.clear, color: Colors.white),
                        ),
                      ))
                ],
              ));
        });
  }
}
