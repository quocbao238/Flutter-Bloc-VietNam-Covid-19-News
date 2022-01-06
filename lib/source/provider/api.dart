// ignore_for_file: avoid_print, empty_catches

import 'package:http/http.dart' as http;
import 'package:vietnamcovidtracking/source/models/province_model.dart';
import 'package:vietnamcovidtracking/source/models/statistical_chart_model.dart';
import 'package:vietnamcovidtracking/source/models/sum_patient_model.dart';

class Api {
  static const String _domain = "https://emag.thanhnien.vn/covid19/home";

  // Lấy tổng ca nhiễm, điều trị khỏi bệnh, tử vong..
  static Future<SummPatient?> getSummPatient() async {
    SummPatient? _result;
    try {
      var url = Uri.parse('$_domain/getSummPatient');
      http.Response response = await http.post(url);
      if (response.statusCode == 200) {
        _result = summPatientFromJson(response.body);
        return _result;
      }
    } catch (e) {}
    return _result;
  }

  // Biểu đồ thống kê ca nhiễm và tử vong
  // Lấy thống kê theo tỉnh thành
  //@param provinceId
  static Future<List<StatisticalChartItem>> getChartCovidByProvinceId(
      {String? provinceId}) async {
    provinceId ??= "";
    List<StatisticalChartItem> _result = [];
    try {
      var url = Uri.parse('$_domain/GetChartCovid');
      http.Response response = await http.post(url, body: {"provinceId": provinceId});
      if (response.statusCode == 200) {
        _result = statisticalChartFromJson(response.body).list;
        return _result;
      }
    } catch (e) {
      print(e);
    }
    return _result;
  }

  // Lấy danh sách tỉnh thành trong nước
  static Future<List<Province>> getAllPatientProvinces() async {
    List<Province> _result = [];
    try {
      var url = Uri.parse('$_domain/getAllPatientProvinces');
      http.Response response = await http.post(url);
      if (response.statusCode == 200) {
        _result = provinceModelFromJson(response.body).list;
        return _result;
      }
    } catch (e) {
      print(e);
    }
    return _result;
  }
}
