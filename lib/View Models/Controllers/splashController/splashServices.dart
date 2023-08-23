import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/View/HomeView/HomeView.dart';

class SplashServices {
  void movetoHome(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ));
    });
  }
}
