// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Utils/Assets/image_asset.dart';
import 'package:news_app/Utils/Color/AppColors.dart';

import '../../View Models/Controllers/splashController/splashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final services = SplashServices();
  @override
  void initState() {
    //implement initState
    super.initState();
    services.movetoHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image(
                  fit: BoxFit.cover,
                  height: Get.height * 0.5,
                  width: Get.width * 0.9,
                  image: const AssetImage(ImageAsset.splashImage)),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text('TOP HEADLINES',
                style: GoogleFonts.anton(
                    letterSpacing: 0.6, color: AppColor.greyColor)),
            SizedBox(
              height: Get.height * 0.02,
            ),
            SpinKitChasingDots(
              color: AppColor.splashSpinKitColor,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
