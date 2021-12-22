part of 'tabpage_bloc.dart';

abstract class TabPageEvent extends Equatable {
  const TabPageEvent();
}

class ChangeTabEvent extends TabPageEvent {
  final int newIndex;
  const ChangeTabEvent({required this.newIndex});
  @override
  List<Object?> get props => [newIndex];
}
