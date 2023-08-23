import 'package:get/get.dart';
import 'package:news_app/Models/categoryModel.dart';
import 'package:news_app/data/repository/categoryRepo.dart';

import '../../../data/status.dart';

class CategoryViewModelController extends GetxController {
  final _api = CategoryRepo();
  RxList<String> categoryList = [
    'general',
    'Health',
    'Entertainment',
    'Sports',
    'Bussiness',
    'Technology',
  ].obs;

  var categoryname = 'general'.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final categoryNews = CategoryModel().obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setCategoryNews(CategoryModel value) => categoryNews.value = value;

  void setCategory(var value) {
    categoryname.value = value;
    setRxRequestStatus(Status.LOADING);
    getCategoryNews();
  }

  void getCategoryNews() {
    _api.getCategoryNews(categoryname.value).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setCategoryNews(value);
    }).onError((error, stackTrace) {
      setRxRequestStatus(Status.ERROR);
      Get.snackbar('Error', error.toString());
    });
  }
}
