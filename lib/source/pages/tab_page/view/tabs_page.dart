import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/config/vn_covid_icon_icons.dart';
import 'package:vietnamcovidtracking/source/pages/tab_page/bloc/tabpage_bloc.dart';

class TabsPage extends StatefulWidget {
  static const String routeName = "/tabsPage";
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    Widget scaffoldView(TabPageState state) {
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text("Demo"),

          //   shadowColor: Colors.transparent,
          // flexibleSpace: Container(
          //   color: ThemePrimary.primaryColor,
          // ),

          //home,barChartAlt,newspaperAlt,infoCircle
          leading: Icon(LineIcons.newspaperAlt),
        ),
        drawer: Drawer(),
      );
    }

    return BlocProvider(
        create: (context) => TabPageBloc(),
        child: BlocBuilder<TabPageBloc, TabPageState>(
            builder: (context, state) => scaffoldView(state)));
  }
}
