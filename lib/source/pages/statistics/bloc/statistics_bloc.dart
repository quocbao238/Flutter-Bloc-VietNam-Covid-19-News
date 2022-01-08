import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vietnamcovidtracking/source/models/province_model.dart';
import 'package:vietnamcovidtracking/source/models/statistical_chart_model.dart';
import 'package:vietnamcovidtracking/source/models/sum_patient_model.dart';
import 'package:vietnamcovidtracking/source/models/view_chart_data.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';
import 'package:vietnamcovidtracking/source/widget/province_dialog_widget.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  SummPatient? summPatient;
  List<Province> lstProvince = [];
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
    lstProvince = await Api.getAllPatientProvinces();
    // if (lstProvince.isNotEmpty) {
    Province? _province = Province();
    _province.id = "";
    _province.title = "Toàn quốc";
    lstProvince.insert(0, _province);
    // }

    provinceSelected = lstProvince.first;
    emit(const LoadingSucessState());
  }

  void onChangeProvince(
      ChangeProvinceEvent event, Emitter<StatisticsState> emit) async {
    Province? _newProvince = await showDialog(
        context: event.context,
        builder: (context) {
          return ProvinceSelectDialog(
              provinceSelected: event.lastProvince, lstProvince: lstProvince);
        });

    if (_newProvince != null) {
      emit(const OnLoadingChartState());
      provinceSelected = _newProvince;
      List<StatisticalChartItem> _lstStatisticalChart =
          await Api.getChartCovidByProvinceId(
              provinceId: provinceSelected?.id ?? "");
      if (_lstStatisticalChart.isNotEmpty) {
        lstChartData = createListChartData(_lstStatisticalChart);
      }
    }

    emit(const LoadingSucessState());
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
