part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class LoadEvent extends MapEvent {
  const LoadEvent();
  @override
  List<Object?> get props => [];
}

class ChangeMapListEvent extends MapEvent {
  final bool isViewMap;
  const ChangeMapListEvent(this.isViewMap);
  @override
  List<Object?> get props => [];
}

class RefeshEvent extends MapEvent {
  const RefeshEvent();
  @override
  List<Object?> get props => [];
}

class SearchProvinceEvent extends MapEvent {
  final String keySearch;
  const SearchProvinceEvent({required this.keySearch});
  @override
  List<Object?> get props => [keySearch];
}
