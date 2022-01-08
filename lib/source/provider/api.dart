// ignore_for_file: avoid_print, empty_catches

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:vietnamcovidtracking/source/helper/rss_helpder.dart';
import 'package:vietnamcovidtracking/source/models/news_model.dart';
import 'package:vietnamcovidtracking/source/models/province_map_model.dart';
import 'package:vietnamcovidtracking/source/models/province_model.dart';
import 'package:vietnamcovidtracking/source/models/statistical_chart_model.dart';
import 'package:vietnamcovidtracking/source/models/sum_patient_model.dart';
import 'package:webfeed/webfeed.dart';

class Api {
  static const String _domain = "https://emag.thanhnien.vn/covid19/home";
  static const String urlNews =
      "https://thanhnien.vn/rss/thoi-su/dan-sinh-176.rss";

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
    } catch (e) {
      print(e);
    }
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
      http.Response response =
          await http.post(url, body: {"provinceId": provinceId});
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

  // Lấy dữ liệu theo các tỉnh
  static Future<List<ProvinceMap>> getProvincesMap() async {
    List<ProvinceMap> _result = [];
    try {
      var url = Uri.parse('$_domain/getProvincesMap');
      http.Response response = await http.post(url);
      if (response.statusCode == 200) {
        _result = provinceMapModelFromJson(response.body).list;
        return _result;
      }
    } catch (e) {
      print(e);
    }
    return _result;
  }

  // Lấy danh sách tin tức mới nhất về covid
  static Future<RssFeed?> getNewsCovid() async {
    try {
      var url = Uri.parse('$urlNews');
      http.Response response = await http.get(url);
      String body = utf8.decode(response.bodyBytes);
      print(body.toString());
      var data = RssFeed.parse(body);
      return data;
    } catch (e) {}
    return null;
  }

  static Future<List<NewsModel>> getListCovidNews() async {
    Set<String> _filterCovid = {"ncov", "covid"};
    var rssFeed = await getNewsCovid();
    List<NewsModel> lstNews = [];
    try {
      if (rssFeed != null) {
        for (var item in rssFeed.items!) {
          // ignore: avoid_function_literals_in_foreach_calls
          _filterCovid.forEach((element) {
            if (!item.link!.toLowerCase().contains(element)) return;
          });
          NewsModel newsModel = NewsModel(
              image: RssHelper.getImageFromFeed(item.description!),
              link: item.link!.replaceAll('\'', ""),
              pubDate: DateFormat('dd/MM/yyyy').format(item.pubDate!),
              title: item.title!);
          lstNews.add(newsModel);
        }
      }
    } catch (e) {}
    print(lstNews);
    return lstNews;
  }
}
