import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tabpage_event.dart';
part 'tabpage_state.dart';

class TabPageBloc extends Bloc<TabPageEvent, TabPageState> {
  TabPageBloc() : super(TabPageState(index: 0)) {
    on<ChangeTabEvent>(_onChangeTabPage);
  }

  void _onChangeTabPage(
      ChangeTabEvent event, Emitter<TabPageState> emit) async {
    int _index = event.newIndex;
    // state.index = _index;
    emit(state.copyWith(index: _index));
  }
}
