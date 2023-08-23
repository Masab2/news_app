// ignore_for_file: unrelated_type_equality_checks

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Utils/Color/AppColors.dart';
import 'package:news_app/View%20Models/Controllers/CategoryNewsController/categoryViewModel.dart';
import 'package:news_app/data/status.dart';

import '../../Utils/utils.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final categoryController = Get.put(CategoryViewModelController());

  @override
  void initState() {
    //implement initState
    super.initState();
    categoryController.getCategoryNews();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            'News Category',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
              child: SizedBox(
                height: Get.height * 0.05,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categoryController.categoryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(right: Get.width * 0.02),
                        child: Obx(() {
                          return InkWell(
                            onTap: () {
                              categoryController.setCategory(
                                  categoryController.categoryList[index]);
                            },
                            child: Container(
                              height: Get.height * 0.08,
                              width: Get.width * 0.28,
                              decoration: BoxDecoration(
                                  color: categoryController.categoryname ==
                                          categoryController.categoryList[index]
                                      ? AppColor.splashSpinKitColor
                                      : AppColor.greyColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  categoryController.categoryList[index],
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          );
                        }));
                  },
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                switch (categoryController.rxRequestStatus.value) {
                  case Status.LOADING:
                    return SpinKitCircle(
                      color: AppColor.splashSpinKitColor,
                      size: 40,
                    );
                  case Status.ERROR:
                    return SpinKitCircle(
                      color: AppColor.splashSpinKitColor,
                      size: 40,
                    );
                  case Status.COMPLETED:
                    return ListView.builder(
                      itemCount: categoryController
                          .categoryNews.value.articles!.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
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
                                      Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                height: Get.height * 0.18,
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.01,
                                    right: Get.width * 0.01),
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
                    );
                }
              }),
            )
          ],
        ));
  }
}
