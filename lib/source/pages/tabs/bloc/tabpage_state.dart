part of 'tabpage_bloc.dart';

class TabPageState extends Equatable {
  final int index;
  TabPageState({this.index = 0});

  TabPageState copyWith({int? index}) =>
      TabPageState(index: index ?? this.index);

  @override
  List<Object> get props => [index];
}
