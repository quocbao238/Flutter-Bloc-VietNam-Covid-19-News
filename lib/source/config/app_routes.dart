import 'package:flutter/material.dart';
import 'package:vietnamcovidtracking/source/models/news_model.dart';
import 'package:vietnamcovidtracking/source/pages/news_detail/news_detail.dart';
import 'package:vietnamcovidtracking/source/pages/tabs/view/tabs_page.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    debugPrint('onGenerateRoute: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const TabsPage(),
          settings: const RouteSettings(name: TabsPage.routeName),
        );
      case TabsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const TabsPage(),
          settings: const RouteSettings(name: TabsPage.routeName),
        );
      case NewsDetailPage.routeName:
        return MaterialPageRoute(
          builder: (_) => NewsDetailPage(
            newsModel: settings.arguments as NewsModel,
          ),
          settings: RouteSettings(
              name: NewsDetailPage.routeName, arguments: settings.arguments),
        );

      // case LocationScreen.routeName:
      //   return LocationScreen.route();
      // case FilterScreen.routeName:
      //   return FilterScreen.route();
      // case RestaurantDetailsScreen.routeName:
      //   return RestaurantDetailsScreen.route(
      //       restaurant: settings.arguments as Restaurant);
      // case RestaurantListingScreen.routeName:
      //   return RestaurantListingScreen.route(
      //       restaurants: settings.arguments as List<Restaurant>);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
