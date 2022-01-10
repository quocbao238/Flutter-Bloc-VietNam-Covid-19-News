import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/menu.dart';
import 'package:vietnamcovidtracking/source/pages/drawer/bloc/drawer_bloc.dart';
import 'package:vietnamcovidtracking/source/pages/tabs/view/tabs_page.dart';

import 'mydrawer.dart';

class DrawerPage extends StatefulWidget {
  static const String routeName = "/drawer";
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage>
    with SingleTickerProviderStateMixin {
  late GlobalKey _globalKey;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation, _scaleAnimation2, _scaleAnimation3;
  bool drawerShow = false;
  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.7).animate(_controller);
    _scaleAnimation2 = Tween<double>(begin: 1, end: 0.725).animate(_controller);
    _scaleAnimation3 = Tween<double>(begin: 1, end: 0.75).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DrawerBloc(),
        child: BlocListener<DrawerBloc, DrawerState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<DrawerBloc, DrawerState>(
                builder: (context, state) => _scaffold(context))));
  }

  void blocListener(DrawerState state, BuildContext context) {
    if (state is MenuCloseState) {
      _controller.reverse();
      drawerShow = false;
    } else if (state is MeunuOpenState) {
      _controller.forward();
      drawerShow = true;
    }
  }

  Widget _scaffold(BuildContext context) {
    final bloc = BlocProvider.of<DrawerBloc>(context);

    Widget _dashboard(
        {required Animation<double> scaleAnimation,
        required double screenWidth,
        Color? color}) {
      return MyDrawer(
        duration: const Duration(milliseconds: 200),
        onMenuTap: () {
          BlocProvider.of<DrawerBloc>(_globalKey.currentContext!)
              .add(MenuEvent(true, bloc.currentPageIndex));
        },
        scaleAnimation: scaleAnimation,
        isCollapsed: !drawerShow,
        screenWidth: screenWidth,
        child: color == null
            ? InkWell(
                onTap: () {
                  bloc.add(MenuEvent(false, bloc.currentPageIndex));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(drawerShow ? 30.0 : 0.0),
                  ),
                  child: TabsPage(
                    drawerTap: (int pageIndex) {
                      bloc.currentPageIndex = pageIndex;
                      bloc.add(MenuEvent(true, bloc.currentPageIndex));
                    },
                  ),
                ),
              )
            : Material(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                color: color),
      );
    }

    Widget _menuBar() {
      Widget _item({required MenuTabItem menuTabItem}) {
        bool _isSelect = menuTabItem.id == bloc.currentPageIndex;
        return InkWell(
          onTap: () {
            bloc.add(MenuEvent(false, menuTabItem.id));
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width * 0.5,
            margin: const EdgeInsets.only(left: 8.0, bottom: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(menuTabItem.iconData,
                    color: _isSelect
                        ? ThemePrimary.primaryColor
                        : ThemePrimary.textPrimaryColor,
                    size: 24.0),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(menuTabItem.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight:
                                _isSelect ? FontWeight.bold : FontWeight.w400,
                            color: _isSelect
                                ? ThemePrimary.primaryColor
                                : ThemePrimary.textPrimaryColor)))
              ],
            ),
          ),
        );
      }

      return InkWell(
        onTap: () {
          bloc.add(MenuEvent(false, bloc.currentPageIndex));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ThemePrimary.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/news.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Text(
                  "VietNam Covid-19 News",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white),
                ),
              ),
              ...MenuTabItem.listMenuItem
                  .map((e) => _item(menuTabItem: e))
                  .toList(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Version 1.0.0",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      key: _globalKey,
      backgroundColor: ThemePrimary.primaryColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _menuBar(),
          _dashboard(
              scaleAnimation: _scaleAnimation3,
              screenWidth: MediaQuery.of(context).size.width / 1.04,
              color: ThemePrimary.backgroundColor),
          _dashboard(
              scaleAnimation: _scaleAnimation2,
              screenWidth: MediaQuery.of(context).size.width / 1.02,
              color: Colors.teal),
          _dashboard(
              scaleAnimation: _scaleAnimation,
              screenWidth: MediaQuery.of(context).size.width,
              color: null),
        ],
      ),
    );
  }
}
