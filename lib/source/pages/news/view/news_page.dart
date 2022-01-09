import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/pages/news/bloc/news_bloc.dart';
import 'package:vietnamcovidtracking/source/pages/news_detail/news_detail.dart';

class NewsPage extends StatefulWidget {
  static const String routeName = "/newsPage";

  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

        Widget _carouseSlider() {
          Widget __carouseSliderItem(int itemIndex) {
            Widget ___carouseSliderItemTitle(int itemIndex) {
              return Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 8, 32, 8),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(bloc.lstNews[itemIndex].title,
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        Text(bloc.lstNews[itemIndex].pubDate,
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    )),
              );
            }

            Widget ___carouseSliderItemImage(int itemIndex) {
              return CachedNetworkImage(
                  imageUrl: bloc.lstNews[itemIndex].image,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)));
            }

            return Container(
              padding: const EdgeInsets.only(bottom: 2),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3)),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    bloc.add(OnTapItemEvent(
                        newsModel: bloc.lstNews[itemIndex], context: context));
                  },
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Stack(
                        children: <Widget>[
                          ___carouseSliderItemImage(itemIndex),
                          ___carouseSliderItemTitle(itemIndex),
                        ],
                      )),
                ),
              ),
            );
          }

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
                itemCount: 5,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayInterval: const Duration(milliseconds: 4000),
                  autoPlayCurve: Curves.easeInOut,
                  viewportFraction: 1.0,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        __carouseSliderItem(itemIndex)),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _title(),
              Expanded(
                child: state is LoadingState
                    ? _loadingWidget()
                    : RefreshIndicator(
                        onRefresh: () async {
                          bloc.add(const RefeshEvent());
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              _carouseSlider(),
                              ...bloc.lstNews.map((e) {
                                int _index = bloc.lstNews.indexOf(e);
                                return _index < 5
                                    ? const SizedBox()
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 8, right: 8, left: 8),
                                        child: InkWell(
                                          onTap: () {
                                            bloc.add(OnTapItemEvent(
                                                newsModel: e,
                                                context: context));
                                          },
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Ink(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 8,
                                                right: 8),
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
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  // padding: const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: CachedNetworkImage(
                                                      imageUrl: e.image,
                                                      fit: BoxFit.fill,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              backgroundColor:
                                                                  ThemePrimary
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          0.1),
                                                              color: ThemePrimary
                                                                  .primaryColor,
                                                              value:
                                                                  downloadProgress
                                                                      .progress),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),

                                                    //  Image.network(e.image,
                                                    //     fit: BoxFit.fill),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          e.title,
                                                          maxLines: null,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child:
                                                              Text(e.pubDate),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                              }).toList()
                            ],
                          ),
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
