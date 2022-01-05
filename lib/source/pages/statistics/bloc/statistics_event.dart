part of 'statistics_bloc.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();
}

class LoadEvent extends StatisticsEvent {
  const LoadEvent();
  @override
  List<Object?> get props => [];
}

class RefeshEvent extends StatisticsEvent {
  const RefeshEvent();
  @override
  List<Object?> get props => [];
}

class ChangeProvinceEvent extends StatisticsEvent {
  final Province lastProvince;
  final BuildContext context;
  const ChangeProvinceEvent(
      {required this.lastProvince, required this.context});

  @override
  List<Object?> get props => [lastProvince, context];
}
