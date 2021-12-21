import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tabpage_event.dart';
part 'tabpage_state.dart';

class TabPageBloc extends Bloc<TabPageEvent, TabPageState> {
  TabPageBloc() : super(TabpageInitial()) {
    on<TabPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
