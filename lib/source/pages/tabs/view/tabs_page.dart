import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/models.dart';
import 'package:vietnamcovidtracking/source/pages/tabs/bloc/tabpage_bloc.dart';

class TabsPage extends StatefulWidget {
  static const String routeName = "/tabsPage";
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  // final GlobalKey<ScaffoldState> _tabsKey = GlobalKey(); // Create a key

  Widget _body(TabPageState state, BuildContext context) {
    return IndexedStack(
        index: state.index,
        children: [...MenuTabItem.listMenuItem.map((e) => e.widget)]);
  }

  Widget _bottomNavigationBar(TabPageState state, BuildContext context) {
    Color _selectedColor = ThemePrimary.primaryColor;
    return SafeArea(
      child: SalomonBottomBar(
        currentIndex: state.index,
        onTap: (index) {
          context.read<TabPageBloc>().add(ChangeTabEvent(newIndex: index));
        },
        items: MenuTabItem.listMenuItem
            .map((e) => SalomonBottomBarItem(
                icon: Icon(e.iconData),
                title: Text(
                  e.title,
                  overflow: TextOverflow.ellipsis,
                ),
                selectedColor: _selectedColor))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabPageBloc(),
      child: BlocBuilder<TabPageBloc, TabPageState>(
        builder: (context, state) {
          return Scaffold(
            // key: _tabsKey,
            appBar: AppBar(
              backgroundColor: ThemePrimary.primaryColor,
              elevation: 0,
              centerTitle: true,
              // title: Text(
              //   bloc.title,
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline2!
              //       .copyWith(color: Colors.white),
              // ),
              // leading: IconButton(
              //   icon: const Icon(LineIcons.equals),
              //   // onPressed: () => _tabsKey.currentState!.openDrawer(),
              // ),
              // actions: [
              //   IconButton(
              //       icon: const Icon(LineIcons.bell, size: 30.0),
              //       onPressed: () {})
              // ],
            ),
            drawer: const Drawer(),
            body: _body(state, context),
            bottomNavigationBar: _bottomNavigationBar(state, context),
          );
        },
      ),
      // ),
    );
  }
}
