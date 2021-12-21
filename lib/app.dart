import 'package:flutter/material.dart';
import 'source/config/app_routes.dart';
import 'source/config/theme_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VietName Covid-19 Tracking",
      debugShowCheckedModeBanner: false,
      theme: ThemePrimary.theme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: "/",
    );
  }
}
