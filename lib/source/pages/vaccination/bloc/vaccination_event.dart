part of 'vaccination_bloc.dart';

abstract class VaccinationEvent extends Equatable {
  const VaccinationEvent();
}

class LoadEvent extends VaccinationEvent {
  const LoadEvent();
  @override
  List<Object?> get props => [];
}

class RefeshEvent extends VaccinationEvent {
  const RefeshEvent();
  @override
  List<Object?> get props => [];
}

class ReverseAnimationEvent extends VaccinationEvent {
  final bool isReverseAnimation;
  const ReverseAnimationEvent({required this.isReverseAnimation});
  @override
  List<Object?> get props => [isReverseAnimation];
}

class ChangeVaccinViewEvent extends VaccinationEvent {
  final bool isShowVaccin;
  const ChangeVaccinViewEvent({required this.isShowVaccin});
  @override
  List<Object?> get props => [isShowVaccin];
}

class SearchProvinceEvent extends VaccinationEvent {
  final String keySearch;
  const SearchProvinceEvent({required this.keySearch});
  @override
  List<Object?> get props => [keySearch];
}
