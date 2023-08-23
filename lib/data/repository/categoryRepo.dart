import 'package:news_app/Models/categoryModel.dart';
import 'package:news_app/Utils/Urls/AppUrls.dart';
import 'package:news_app/data/Network/networkApiservices.dart';

class CategoryRepo {
  final _apiServices = NetworkApiServices();
  Future<CategoryModel> getCategoryNews(String category) async {
    final response =
        await _apiServices.getApi(AppUrl.bulidUrlCategroy(category));
    return CategoryModel.fromJson(response);
  }
}
