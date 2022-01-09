import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/news_model.dart';

class NewsDetailPage extends StatefulWidget {
  static const String routeName = "/newsDetailPage";
  final NewsModel newsModel;
  const NewsDetailPage({Key? key, required this.newsModel}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.newsModel.link,
      appBar: AppBar(
        backgroundColor: ThemePrimary.primaryColor,
        title: Text(widget.newsModel.title),
      ),
      // withZoom: true,
      withLocalStorage: true,
      // hidden: true,
      initialChild: Container(
          color: ThemePrimary.scaffoldBackgroundColor,
          child: Center(
              child: SizedBox(
                  height: 25,
                  width: 25,
                  child: SpinKitFadingFour(
                      color: ThemePrimary.primaryColor, size: 24.0)))),
    );
  }
}
