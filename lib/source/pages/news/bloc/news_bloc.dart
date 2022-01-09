import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vietnamcovidtracking/source/models/news_model.dart';
import 'package:vietnamcovidtracking/source/pages/news_detail/news_detail.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsModel> lstNews = [];

  NewsBloc() : super(const NewsState()) {
    on<LoadEvent>(onLoadData);
    on<RefeshEvent>(onRefesh);
    on<OnTapItemEvent>(onTapItem);
  }

  void onLoadData(LoadEvent event, Emitter<NewsState> emit) async {
    emit(const LoadingState());
    lstNews = await Api.getListCovidNews();
    if (lstNews.isEmpty) {
      emit(const LoadingSucessState());
      return;
    }
    emit(const LoadingSucessState());
  }

  Future<void> onRefesh(RefeshEvent event, Emitter<NewsState> emit) async {
    lstNews.clear();
    emit(const LoadingState());
    lstNews = await Api.getListCovidNews();
    if (lstNews.isEmpty) {
      emit(const LoadingSucessState());
      return;
    }
    emit(const LoadingSucessState());
  }

  void onTapItem(OnTapItemEvent event, Emitter<NewsState> emit) async {
    Navigator.pushNamed(event.context, NewsDetailPage.routeName,
        arguments: event.newsModel);
  }
}
