part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class LoadEvent extends MapEvent {
  const LoadEvent();
  @override
  List<Object?> get props => [];
}

class RefeshEvent extends MapEvent {
  const RefeshEvent();
  @override
  List<Object?> get props => [];
}

class WarningMapEvent extends MapEvent {
  final BuildContext context;
  const WarningMapEvent(this.context);
  @override
  List<Object?> get props => [];
}
