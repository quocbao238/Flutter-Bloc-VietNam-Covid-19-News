import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/models.dart';
import 'package:vietnamcovidtracking/source/pages/drawer/bloc/drawer_bloc.dart';
import 'package:vietnamcovidtracking/source/pages/tabs/bloc/tabpage_bloc.dart';

class TabsPage extends StatefulWidget {
  final Function(int indexPage)? drawerTap;
  static const String routeName = "/tabsPage";
  const TabsPage({Key? key, this.drawerTap}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final GlobalKey<ScaffoldState> tabsKey = GlobalKey(); // Create a key

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
          return BlocListener<DrawerBloc, DrawerState>(
            listener: (drawercontext, drawerState) {
              if (drawerState is MenuCloseState) {
                context
                    .read<TabPageBloc>()
                    .add(ChangeTabEvent(newIndex: drawerState.newIndex));
              }
            },
            child: Scaffold(
              key: tabsKey,
              appBar: AppBar(
                backgroundColor: ThemePrimary.primaryColor,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => widget.drawerTap!(state.index),
                ),
              ),
              body: _body(state, context),
              bottomNavigationBar: _bottomNavigationBar(state, context),
            ),
          );
        },
      ),
      // ),
    );
  }
}
