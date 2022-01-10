import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  int currentPageIndex = 0;

  DrawerBloc() : super(const DrawerState()) {
    on<MenuEvent>((event, emit) {
      emit(event.isCollapsed
          ? MeunuOpenState(newIndex: event.newIndex)
          : MenuCloseState(newIndex: event.newIndex));
    });
  }
}
