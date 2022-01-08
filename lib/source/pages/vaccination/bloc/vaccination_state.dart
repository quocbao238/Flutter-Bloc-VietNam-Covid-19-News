part of 'vaccination_bloc.dart';

class VaccinationState extends Equatable {
  const VaccinationState();
  @override
  List<Object> get props => [];
}

class LoadingState extends VaccinationState {
  const LoadingState();
  @override
  List<Object> get props => [];
}

class SearchStateSucess extends VaccinationState {
  final String keySearch;
  const SearchStateSucess(this.keySearch);
  @override
  List<Object> get props => [keySearch];
}

class OnTappedFilterState extends VaccinationState {
  final bool isReverseAnimation;
  const OnTappedFilterState(this.isReverseAnimation);
  @override
  List<Object> get props => [isReverseAnimation];
}

class ChangeVaccinViewState extends VaccinationState {
  final bool isShowVacination;
  const ChangeVaccinViewState(this.isShowVacination);
  @override
  List<Object> get props => [isShowVacination];
}

class LoadingSucessState extends VaccinationState {
  const LoadingSucessState();
  @override
  List<Object> get props => [];
}
