part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class LoadEvent extends NewsEvent {
  const LoadEvent();
  @override
  List<Object?> get props => [];
}
