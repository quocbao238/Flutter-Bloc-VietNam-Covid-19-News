import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/province_model.dart';
import 'package:vietnamcovidtracking/source/models/statistical_chart_model.dart';
import 'package:vietnamcovidtracking/source/models/sum_patient_model.dart';
import 'package:vietnamcovidtracking/source/models/view_chart_data.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  SummPatient? summPatient;
  List<Province>? lstProvince;
  List<ChartData>? lstChartData;
  Province? provinceSelected;
  bool? loadingChart;

  StatisticsBloc() : super(const StatisticsState()) {
    on<LoadEvent>(onLoadData);
    on<ChangeProvinceEvent>(onChangeProvince);
  }

  void onLoadData(StatisticsEvent event, Emitter<StatisticsState> emit) async {
    emit(const LoadingState());
    summPatient = await Api.getSummPatient();
    List<StatisticalChartItem> _lstStatisticalChart =
        await Api.getChartCovidByProvinceId();
    if (_lstStatisticalChart.isNotEmpty) {
      lstChartData = createListChartData(_lstStatisticalChart);
    }
    List<Province> lstProvince = await Api.getAllPatientProvinces();
    if (lstProvince.isNotEmpty) {
      Province? _province = Province();
      _province.id = "-99";
      _province.title = "Toàn quốc";
      lstProvince.insert(0, _province);
    }
    provinceSelected = lstProvince.first;
    emit(const LoadingSucessState());
  }

  void onChangeProvince(
      ChangeProvinceEvent event, Emitter<StatisticsState> emit) async {
    emit(const OnLoadingChartState());
    Province _lastProvince = event.lastProvince;
    await showDialog(
        context: event.context,
        builder: (context) {
          return Dialog(
            // elevation: 4,
            backgroundColor: Colors.transparent,

            insetPadding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 32, right: 8),
            child: Stack(
              // ignore: deprecated_member_use
              overflow: Overflow.visible,
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(right: 24.0, top: 40),
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    padding: const EdgeInsets.fromLTRB(20, 54, 20, 20),
                    child: Column(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                              primaryColor: ThemePrimary.primaryColor,
                              accentColor: ThemePrimary.primaryColor),
                          child: TextField(
                            // controller: _searchController,
                            decoration: InputDecoration(
                                labelText: "Tìm kiếm tỉnh thành",
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: ThemePrimary.primaryColor),
                                hintText: "Nhập tỉnh thành cần tìm",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: ThemePrimary.primaryColor,
                                ),
                                suffix: InkWell(
                                  child: const Icon(Icons.clear),
                                  onTap: () {},
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ThemePrimary.primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ThemePrimary.primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ThemePrimary.primaryColor))),
                          ),
                        ),
                        ListView(
                            shrinkWrap: true,
                            children:
                                (lstProvince != null && lstProvince!.isNotEmpty)
                                    ? lstProvince!
                                        .map((e) => Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8, bottom: 8),
                                              child: Text(e.title!),
                                            ))
                                        .toList()
                                    : []),
                      ],
                    )),
                Positioned(
                    top: 0,
                    child: Container(
                        height: 80,
                        width: 80,
                        margin: const EdgeInsets.only(right: 24),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemePrimary.primaryColor),
                        child: const Center(
                            child: Icon(
                          Icons.location_city,
                          color: Colors.white,
                          size: 48,
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
            ),
          );
        });

    emit(const LoadingSucessState());

    // print(event.buildContext);
    // print(event);

    // Province? _lastSelectedProvince = event.lastProvince;
    // emit(const LoadingState());
    // SummPatient? _summPatient = await Api.getSummPatient();
    // List<ChartData> _lstChartData = [];
    // List<StatisticalChartItem> _lstStatisticalChart =
    //     await Api.getChartCovidByProvinceId();
    // if (_lstStatisticalChart.isNotEmpty) {
    //   _lstChartData = createListChartData(_lstStatisticalChart);
    // }
    // List<Province> lstProvince = await Api.getAllPatientProvinces();
    // if (lstProvince.isNotEmpty) {
    //   Province? _province = Province();
    //   _province.id = "-99";
    //   _province.title = "Toàn quốc";
    //   lstProvince.insert(0, _province);
    // }
    // Province _provinceSelect = lstProvince.first;
    // emit(state.copyWith(
    //     summPatient: _summPatient,
    //     provinceSelected: _provinceSelect,
    //     lstChartData: _lstChartData,
    //     lstProvince: lstProvince));
  }

  List<ChartData> createListChartData(
      List<StatisticalChartItem> _lstStatisticalChartItem) {
    List<ChartData> _result = [];
    _result = _lstStatisticalChartItem
        .map((e) =>
            ChartData(x: e.date, y: e.confirmed, secondSeriesYValue: e.death))
        .toList();
    return _result;
  }
}
