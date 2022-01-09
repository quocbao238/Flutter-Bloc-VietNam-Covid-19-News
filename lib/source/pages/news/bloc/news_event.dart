part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class LoadEvent extends NewsEvent {
  const LoadEvent();
  @override
  List<Object?> get props => [];
}

class RefeshEvent extends NewsEvent {
  const RefeshEvent();
  @override
  List<Object?> get props => [];
}

class OnTapItemEvent extends NewsEvent {
  final BuildContext context;
  final NewsModel newsModel;
  const OnTapItemEvent({required this.newsModel, required this.context});
  @override
  List<Object?> get props => [newsModel];
}
