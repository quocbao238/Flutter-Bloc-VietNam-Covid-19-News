import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vietnamcovidtracking/source/models/province_model.dart';
import 'package:vietnamcovidtracking/source/models/statistical_chart_model.dart';
import 'package:vietnamcovidtracking/source/models/sum_patient_model.dart';
import 'package:vietnamcovidtracking/source/models/view_chart_data.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  // final SummPatient? summPatient;
  // final List<Province>? lstProvince;
  // final List<ChartData>? lstChartData;
  // final Province? provinceSelected;
  // final bool? loadingChart;

  StatisticsBloc() : super(const StatisticsState()) {
    on<OnLoadEvent>(onLoadData);
    on<ChangeProvinceEvent>(onChangeProvince);
  }

  void onChangeProvince(
      ChangeProvinceEvent event, Emitter<StatisticsState> emit) async {
    emit(const OnLoadingChartState());
    emit(state.copyWith(loadingChart: true));

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

  void onLoadData(StatisticsEvent event, Emitter<StatisticsState> emit) async {
    emit(const LoadingState());
    SummPatient? _summPatient = await Api.getSummPatient();
    List<ChartData> _lstChartData = [];
    List<StatisticalChartItem> _lstStatisticalChart =
        await Api.getChartCovidByProvinceId();
    if (_lstStatisticalChart.isNotEmpty) {
      _lstChartData = createListChartData(_lstStatisticalChart);
    }
    List<Province> lstProvince = await Api.getAllPatientProvinces();
    if (lstProvince.isNotEmpty) {
      Province? _province = Province();
      _province.id = "-99";
      _province.title = "Toàn quốc";
      lstProvince.insert(0, _province);
    }
    Province _provinceSelect = lstProvince.first;
    emit(state.copyWith(
        summPatient: _summPatient,
        provinceSelected: _provinceSelect,
        lstChartData: _lstChartData,
        lstProvince: lstProvince));
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
