
import 'package:get/get.dart';
import 'package:news_app/Models/toHeadlinesModel.dart';
import 'package:news_app/data/repository/HomeRepo.dart';
import 'package:news_app/data/status.dart';


class HomeViewController extends GetxController {
  final _api = HomeRepo();
  final selectedFilter = FilterList.bbcNews.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final topheadlinesmodel = TopHeadLinesModel().obs;

  void updateFilter(FilterList option) {
    selectedFilter.value = option;
    getTopHeadLines();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setheadLines(TopHeadLinesModel value) => topheadlinesmodel.value = value;

  void getTopHeadLines() {
    final source = getSourceFromFilter(selectedFilter.value);
    _api.newsHeadlinesApi(source).then((value) {
      setheadLines(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackTrace) {
      setRxRequestStatus(Status.ERROR);
    });
  }

  String getSourceFromFilter(FilterList option) {
    switch (option) {
      case FilterList.bbcNews:
        return 'bbc-news';
      case FilterList.aryNews:
        return 'ary-news';
      case FilterList.alJazeera:
        return 'al-Jazeera-english';
      case FilterList.cbc:
        return 'cbc-news';
      case FilterList.cnn:
        return 'cnn';
      default:
        return 'bbc-news';
    }
  }
}
