part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();

  @override
  List<Object> get props => [];
}

class DrawerInitial extends DrawerState {}

class MenuCloseState extends DrawerState {}

class MeunuOpenState extends DrawerState {}
