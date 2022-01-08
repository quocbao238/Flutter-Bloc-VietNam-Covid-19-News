import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/pages/news/bloc/news_bloc.dart';

class NewsPage extends StatefulWidget {
  static const String routeName = "/newsPage";

  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
  }

  onLoad() async {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(const LoadEvent()),
      child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        final bloc = BlocProvider.of<NewsBloc>(context);

        Widget _title() {
          return Container(
            width: MediaQuery.of(context).size.width,
            color: ThemePrimary.primaryColor,
            padding: const EdgeInsets.only(
                left: SizeApp.normalPadding,
                right: SizeApp.normalPadding,
                bottom: SizeApp.normalPadding),
            child: Text("Tin tức Covid-19 tại Việt Nam",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    overflow: TextOverflow.ellipsis, color: Colors.white)),
          );
        }

        Widget _loadingWidget() {
          return Center(
              child: SizedBox(
                  height: 25,
                  width: 25,
                  child: SpinKitFadingFour(
                      color: ThemePrimary.primaryColor, size: 24.0)));
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _title(),
              state is LoadingState
                  ? _loadingWidget()
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            ...bloc.lstNews
                                .map((e) => Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 8, right: 8, left: 8),
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8, left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4.0,
                                              offset: Offset(0.0, 4.0))
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            // padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(e.image,
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.title,
                                                    maxLines: null,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(e.pubDate),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ))
                                .toList()
                          ],
                        ),
                      ),
                    )
            ],
          ),
        );
      }),
      // ),
    );
  }
}
