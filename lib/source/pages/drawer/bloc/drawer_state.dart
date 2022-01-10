part of 'drawer_bloc.dart';

class DrawerState extends Equatable {
  const DrawerState();
  @override
  List<Object?> get props => [];
}

class MenuCloseState extends DrawerState {
  final int newIndex;
  const MenuCloseState({required this.newIndex});
  @override
  List<Object> get props => [newIndex];
}

class MeunuOpenState extends DrawerState {
  final int newIndex;
  const MeunuOpenState({required this.newIndex});
  @override
  List<Object> get props => [newIndex];
}
