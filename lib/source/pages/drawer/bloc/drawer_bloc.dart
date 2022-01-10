import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    on<MenuEvent>((event, emit) {
      emit(event.isCollapsed ? MeunuOpenState() : MenuCloseState());
    });
  }
}
