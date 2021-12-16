import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'source/config/theme_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [],
        child: MultiBlocProvider(
          providers: [],
          child: MaterialApp(
            title: "VietName Covid-19 Tracking",
            debugShowCheckedModeBanner: false,
            theme: ThemePrimary.theme(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
          ),
        ));
  }
}
