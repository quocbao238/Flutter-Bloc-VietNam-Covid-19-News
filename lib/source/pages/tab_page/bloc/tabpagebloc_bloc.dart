import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tabpagebloc_event.dart';
part 'tabpagebloc_state.dart';

class TabpageblocBloc extends Bloc<TabpageblocEvent, TabpageblocState> {
  TabpageblocBloc() : super(TabpageblocInitial()) {
    on<TabpageblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
