import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'source/config/app_routes.dart';
import 'source/config/theme_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "VietNam Covid-19 News",
      debugShowCheckedModeBanner: false,
      theme: ThemePrimary.theme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: "/",
    );
  }
}
