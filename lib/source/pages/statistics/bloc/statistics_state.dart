part of 'statistics_bloc.dart';

class StatisticsState extends Equatable {
  final SummPatient? summPatient;
  final List<Province>? lstProvince;
  final List<ChartData>? lstChartData;
  final Province? provinceSelected;
  final bool? loadingChart;

  const StatisticsState({
    this.lstChartData,
    this.loadingChart = false,
    this.summPatient,
    this.lstProvince,
    this.provinceSelected,
  });

  StatisticsState copyWith(
          {SummPatient? summPatient,
          List<Province>? lstProvince,
          List<ChartData>? lstChartData,
          bool? loadingChart,
          Province? provinceSelected}) =>
      StatisticsState(
        summPatient: summPatient ?? this.summPatient,
        lstProvince: lstProvince ?? this.lstProvince,
        lstChartData: lstChartData ?? this.lstChartData,
        loadingChart: loadingChart ?? this.loadingChart,
        provinceSelected: provinceSelected ?? this.provinceSelected,
      );

  @override
  List<Object> get props => [];
}

class LoadingState extends StatisticsState {
  const LoadingState();
  @override
  List<Object> get props => [];
}

class OnLoadingChartState extends StatisticsState {
  const OnLoadingChartState();
  @override
  List<Object> get props => [];
}
