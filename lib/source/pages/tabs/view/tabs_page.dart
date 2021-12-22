import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:line_icons/line_icons.dart';
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
  final GlobalKey<ScaffoldState> _tabsKey = GlobalKey(); // Create a key

  Widget _body(TabPageState state, BuildContext context) {
    return IndexedStack(
        index: state.index,
        children: [...MenuTabItem.listMenuItem.map((e) => e.widget)]);
  }

  Widget _bottomNavigationBar(TabPageState state, BuildContext context) {
    return SnakeNavigationBar.color(
      backgroundColor: Colors.white,
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.circle,
      snakeViewColor: ThemePrimary.primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: ThemePrimary.primaryColor,
      showUnselectedLabels: true,
      showSelectedLabels: false,
      height: kToolbarHeight,
      currentIndex: state.index,
      unselectedLabelStyle: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(fontWeight: FontWeight.bold),
      onTap: (index) {
        context.read<TabPageBloc>().add(ChangeTabEvent(newIndex: index));
      },
      items: MenuTabItem.listMenuItem
          .map((e) =>
              BottomNavigationBarItem(icon: Icon(e.iconData), label: e.title))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabPageBloc(),
      child: BlocBuilder<TabPageBloc, TabPageState>(
        builder: (context, state) {
          print("index : ${state.index}");
          return Scaffold(
            key: _tabsKey,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(LineIcons.equals),
                onPressed: () => _tabsKey.currentState!.openDrawer(),
              ),
              actions: [
                IconButton(
                    icon: Icon(LineIcons.bell, size: 30.0), onPressed: () {})
              ],
            ),
            drawer: Drawer(),
            body: _body(state, context),
            bottomNavigationBar: _bottomNavigationBar(state, context),
          );
        },
      ),
      // ),
    );
  }
}
