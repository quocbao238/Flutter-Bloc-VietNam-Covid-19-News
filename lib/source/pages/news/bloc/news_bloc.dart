import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vietnamcovidtracking/source/helper/rss_helpder.dart';
import 'package:vietnamcovidtracking/source/models/news_model.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsModel> lstNews = [];

  NewsBloc() : super(const NewsState()) {
    on<LoadEvent>(onLoadData);
  }

  void onLoadData(LoadEvent event, Emitter<NewsState> emit) async {
    emit(const LoadingState());
    lstNews = await Api.getListCovidNews();
    if (lstNews.isEmpty) {
      emit(const LoadingSucessState());
      return;
    }

    // // Resize 5 item hình -> size lớn để chạy ở header
    // for (int i = 0; i < 6; i++) {
    //   lstNews[i].image = RssHelper.changeSizeImage(
    //       imageUrl: lstNews[i].image, width: 120, height: 80);
    // }

    emit(const LoadingSucessState());
  }
}
