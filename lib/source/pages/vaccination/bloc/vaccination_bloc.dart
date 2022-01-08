import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:vietnamcovidtracking/source/models/province_model.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';

part 'vaccination_event.dart';
part 'vaccination_state.dart';

class VaccinationBloc extends Bloc<VaccinationEvent, VaccinationState> {
  List<Province> lstProvince = [];
  List<Province> lstSearchProvince = [];
  bool isShowVacination = false;
  bool isReverseAnimation = true;

  VaccinationBloc() : super(const VaccinationState()) {
    on<LoadEvent>(onLoadData);
    on<SearchProvinceEvent>(onSearchProvince);
    on<ChangeVaccinViewEvent>(onChangeVaccinView);
    on<ReverseAnimationEvent>(onHandelAnimation);
  }

  void onLoadData(LoadEvent event, Emitter<VaccinationState> emit) async {
    emit(const LoadingState());
    lstProvince = await Api.getAllPatientProvinces();
    lstSearchProvince.addAll(lstProvince);
    emit(const LoadingSucessState());
  }

  void onSearchProvince(
      SearchProvinceEvent event, Emitter<VaccinationState> emit) {
    if (lstProvince.isEmpty) emit(const LoadingSucessState());
    String _keySearch = TiengViet.parse(event.keySearch).toLowerCase();
    lstSearchProvince.clear();
    if (_keySearch.isEmpty) {
      lstSearchProvince.addAll(lstProvince);
    } else {
      lstSearchProvince = lstProvince
          .where((element) => TiengViet.parse(element.title!)
              .toLowerCase()
              .contains(_keySearch))
          .toList();
    }
    emit(SearchStateSucess(_keySearch));
  }

  void onChangeVaccinView(
      ChangeVaccinViewEvent event, Emitter<VaccinationState> emit) {
    isShowVacination = event.isShowVaccin;
    isReverseAnimation = true;
    emit(ChangeVaccinViewState(isShowVacination));
  }

  void onHandelAnimation(
      ReverseAnimationEvent event, Emitter<VaccinationState> emit) {
    isReverseAnimation = event.isReverseAnimation;
    emit(OnTappedFilterState(isReverseAnimation));
  }
}
