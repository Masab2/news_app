import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:news_app/data/Network/BaseApiServices.dart';
import 'package:news_app/data/app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApi(String url) async {
    dynamic reponseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      reponseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on ClientException {
      throw ClientException();
    }
    return reponseJson;
  }

  // Handel the Api Reponse
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw FetchDataExceptions(
            'Error While Fetching the data ${response.statusCode}');
      case 104:
        throw ClientException(
            'Error While Client Fetch Data ${response.statusCode}');
      default:
        throw FetchDataExceptions('Error While Fetching the data');
    }
  }
}
