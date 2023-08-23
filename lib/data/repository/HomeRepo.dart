import 'package:flutter/material.dart';
import 'package:news_app/Models/toHeadlinesModel.dart';
import 'package:news_app/Utils/Urls/AppUrls.dart';
import 'package:news_app/data/Network/networkApiservices.dart';

class HomeRepo {
  final _apiServices = NetworkApiServices();

  Future<TopHeadLinesModel> newsHeadlinesApi(String source) async {
    final response = await _apiServices.getApi(AppUrl.bulidUrl(source));
    debugPrint(response.toString());
    return TopHeadLinesModel.fromJson(response);
  }
}
