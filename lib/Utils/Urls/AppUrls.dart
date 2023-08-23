class AppUrl {
  static const String appId = '6893aa3470ad4c5ab4cf715adb841fc4';

  static String bulidUrl(String source) {
    return 'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=$appId';
  }

  static String bulidUrlCategroy(String category) {
    return 'https://newsapi.org/v2/everything?q=$category&apiKey=$appId';
  }
}
