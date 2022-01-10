part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();

  @override
  List<Object> get props => [];
}

class MenuEvent extends DrawerEvent {
  final bool isCollapsed;
  const MenuEvent(this.isCollapsed);
}
