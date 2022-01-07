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

// [danh sách vùng]
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
      //start
      String data = await rootBundle.loadString('assets/vietnam.json');
      var jsonResult = json.decode(data);
      // List thứ nhất parse từ json local
      MapModelAsset _mapModel = MapModelAsset.fromJson(jsonResult);

      // // Map thành listMapModel để hiển thị lên UI
      // listMapModel = _mapModel.features.map((e) {
      //   //map vo day luon là tiet kiem dc 1 cai for r ne
      //   return MapModelView(
      //       title: e.properties.name1,
      //       color: ThemePrimary.primaryColor,
      //       total: 0);
      // }).toList();
      // //end
      // //bỏ khúc này vào cái for lstProvinceMap

      // List lấy dữ liệu các ca nhiễm từ api
      List<ProvinceMap> lstProvinceMap = await Api.getProvincesMap();

      // For list dữ liệu để map với listMapModel
      await Future.forEach(lstProvinceMap, (ProvinceMap element) {
        if (element.data == null || element.data!.isEmpty) return;
        // Set màu tùy theo khu vực, dựa vào ProvinceMap.title
        Color? _colors = mapColorByCount[element.name];
        List<String> _titleSet =
            element.data!.map((e) => e.title.toString()).toList();

        // Map thành listMapModel để hiển thị lên UI
        // listMapModel = _mapModel.features.map((e) {
        for (var e in _mapModel.features) {
          //map vo day luon là tiet kiem dc 1 cai for r ne
          // Kiểm tra mapModelView có nằm trong [danh sách vùng] không
          if (_titleSet.contains(e.properties.name1)) {
            //nếu có thì set màu vùng và số lượng ca nhiễm
            // mapModelView.color = _colors ?? ThemePrimary.primaryColor;

            // Số lượng ca nhiễm sẽ check list [element.data] nằm trong dữ liệu api trả về -> map số lượng ca nhiễm vào
            // mapModelView.total = element.data!
            //         .firstWhere(
            //             (element) => element.title == mapModelView.title)
            //         .confirmed ??
            //     0;
            listMapModel.add(MapModelView(
                title: e.properties.name1,
                color: _colors ?? ThemePrimary.primaryColor,
                total: element.data!
                        .firstWhere(
                            (element) => element.title == e.properties.name1)
                        .confirmed ??
                    0));
          }
        }
        //end
        //bỏ khúc này vào cái for lstProvinceMap

        // Fix dữ liệu hcm bị null
        // cái này là do có trường hợp HCM trả về title null nên phải check

        //chỗ này ko hiểu :))
        // Anh ẩn đi không ảnh hưởng dâu, do cái title của HCM api trả về null nên em thêm text cho nó thôi
        // để vậy chắc ko sao , e chạy thử xem
        // OK a
        // if (_titleSet.contains("")) {
        //   listMapModel
        //       .firstWhere((element) => element.title == "Hồ Chí Minh")
        //       .total = element.data!
        //           .firstWhere((element) => element.title == "")
        //           .confirmed ??
        //       0;
        // }
        // for (MapModelView mapModelView in listMapModel) {
        //   // Kiểm tra mapModelView có nằm trong [danh sách vùng] không
        //   if (_titleSet.contains(mapModelView.title)) {
        //     //nếu có thì set màu vùng và số lượng ca nhiễm
        //     mapModelView.color = _colors ?? ThemePrimary.primaryColor;

        //     // Số lượng ca nhiễm sẽ check list [element.data] nằm trong dữ liệu api trả về -> map số lượng ca nhiễm vào
        //     mapModelView.total = element.data!
        //             .firstWhere(
        //                 (element) => element.title == mapModelView.title)
        //             .confirmed ??
        //         0;
        //   }
        // }
      });
    } catch (e) {
      print(e);
    }
    // Nãy bị văng catch nên không có new mapSource
    mapSource = MapShapeSource.asset('assets/vietnam.json',
        shapeDataField: "NAME_1",
        dataCount: listMapModel.length,
        primaryValueMapper: (int index) => listMapModel[index].title,
        shapeColorValueMapper: (int index) =>
            listMapModel[index].total.toDouble(),
        shapeColorMappers: _shapeColorMappers);

    emit(const LoadingSucessState());
  }
}
