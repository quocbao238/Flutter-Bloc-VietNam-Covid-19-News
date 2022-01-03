import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child:
              SpinKitFadingFour(color: ThemePrimary.primaryColor, size: 24.0)),
    );
  }
}
