part of 'statistics_bloc.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();
}

class OnLoadEvent extends StatisticsEvent {
  const OnLoadEvent();

  @override
  List<Object?> get props => [];
}

class ChangeProvinceEvent extends StatisticsEvent {
  // final BuildContext buildContext; 
  final Province? lastProvince;
  const ChangeProvinceEvent({this.lastProvince});

  @override
  List<Object?> get props => [lastProvince];
}
