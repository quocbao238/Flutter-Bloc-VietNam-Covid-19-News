part of 'tabpage_bloc.dart';

abstract class TabPageEvent extends Equatable {
  TabPageEvent();
}

class ChangeTabEvent extends TabPageEvent {
  final int newIndex;
  ChangeTabEvent({
    required this.newIndex,
  });
  @override
  List<Object?> get props => [newIndex];
}
