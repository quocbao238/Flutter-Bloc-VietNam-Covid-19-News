import 'package:flutter/material.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/helper/rss_helpder.dart';
import 'package:vietnamcovidtracking/source/provider/api.dart';

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

  onLoad() async {
    var a = await Api.getListCovidNews();
    print(a);
    print(RssHelper.changeSizeImage(
        imageUrl: a[0].image, width: 120, height: 60));
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _title(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onLoad();
        },
      ),
    );
  }
}
