import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Utils/Assets/image_asset.dart';
import 'package:news_app/Utils/Color/AppColors.dart';
import 'package:news_app/Utils/utils.dart';
import 'package:news_app/View%20Models/Controllers/CategoryNewsController/categoryViewModel.dart';
import 'package:news_app/View%20Models/Controllers/HomeController/HomeViewController.dart';
import 'package:news_app/View/CategoryView/categoryView.dart';
import 'package:news_app/data/status.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.put(HomeViewController());
  final categoryController = Get.put(CategoryViewModelController());
  @override
  void initState() {
    //implement initState
    super.initState();
    homeController.getTopHeadLines();
    categoryController.getCategoryNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryView(),
                  ));
            },
            icon: Image.asset(
              ImageAsset.homeicon,
              height: Get.height * 0.06,
              width: Get.width * 0.06,
            ),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<FilterList>(
              onSelected: (FilterList item) {
                homeController.updateFilter(item);
              },
              itemBuilder: (context) {
                return <PopupMenuEntry<FilterList>>[
                  const PopupMenuItem<FilterList>(
                    value: FilterList.bbcNews,
                    child: Text('BBC News'),
                  ),
                  const PopupMenuItem<FilterList>(
                    value: FilterList.aryNews,
                    child: Text('Ary News'),
                  ),
                  const PopupMenuItem<FilterList>(
                    value: FilterList.alJazeera,
                    child: Text('AL Jazeera News'),
                  ),
                  const PopupMenuItem<FilterList>(
                    value: FilterList.cbc,
                    child: Text('CBC News'),
                  ),
                  const PopupMenuItem<FilterList>(
                    value: FilterList.cnn,
                    child: Text('CNN News'),
                  )
                ];
              },
            )
          ],
          title: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        body: ListView(
          children: [
            Obx(() {
              switch (homeController.rxRequestStatus.value) {
                case Status.LOADING:
                  return SpinKitCircle(
                    color: AppColor.splashSpinKitColor,
                    size: 40,
                  );
                case Status.ERROR:
                  return const Text('SomeThing Went Wrong');
                case Status.COMPLETED:
                  return SizedBox(
                    height: Get.height * 0.55,
                    width: double.infinity,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController
                          .topheadlinesmodel.value.articles!.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: Get.height * 0.6,
                                width: Get.width * 0.9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.height * 0.02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: homeController.topheadlinesmodel
                                        .value.articles![index].urlToImage
                                        .toString(),
                                    placeholder: (context, url) =>
                                        const SpinKitCircle(
                                      size: 40,
                                      color: Colors.amber,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.03,
                                        vertical: Get.height * 0.01),
                                    height: Get.height * 0.22,
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: Get.width * 0.7,
                                          child: Text(
                                              homeController.topheadlinesmodel
                                                  .value.articles![index].title
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: Get.width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  homeController
                                                      .topheadlinesmodel
                                                      .value
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    color: AppColor
                                                        .splashSpinKitColor,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Text(
                                                  Utils.dateFormated(
                                                      homeController
                                                          .topheadlinesmodel
                                                          .value
                                                          .articles![index]
                                                          .publishedAt
                                                          .toString()),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
              }
            }),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Obx(() {
              switch (categoryController.rxRequestStatus.value) {
                case Status.LOADING:
                  return SpinKitCircle(
                    color: AppColor.splashSpinKitColor,
                    size: 40,
                  );
                case Status.ERROR:
                  return Text('Error Occured');
                case Status.COMPLETED:
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: categoryController
                          .categoryNews.value.articles!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.03,
                              vertical: Get.height * 0.01),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: Get.height * 0.18,
                                  width: Get.width * 0.3,
                                  imageUrl: categoryController.categoryNews
                                      .value.articles![index].urlToImage
                                      .toString(),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                height: Get.height * 0.18,
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.03),
                                child: Column(
                                  children: [
                                    Text(
                                      categoryController.categoryNews.value
                                          .articles![index].title
                                          .toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            categoryController
                                                .categoryNews
                                                .value
                                                .articles![index]
                                                .source!
                                                .name
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color:
                                                  AppColor.splashSpinKitColor,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        Text(
                                            Utils.dateFormated(
                                                categoryController
                                                    .categoryNews
                                                    .value
                                                    .articles![index]
                                                    .publishedAt
                                                    .toString()),
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                    ),
                  );
              }
            })
          ],
        ));
  }
}
