import 'package:flutter/material.dart';

class VaccinationPage extends StatefulWidget {
  static const String routeName = "/vaccinationPage";
  const VaccinationPage({Key? key}) : super(key: key);

  @override
  _VaccinationPageState createState() => _VaccinationPageState();
}

class _VaccinationPageState extends State<VaccinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("VaccinationPage"));
  }
}
