import 'package:era_shop/View/MyApp/AppPages/reels_page/controller/reels_controller.dart';
import 'package:era_shop/View/MyApp/AppPages/reels_page/widget/reels_widget.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class ReelsView extends GetView<ReelsController> {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {

    controller.init();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: GetBuilder<ReelsController>(
        id: "onGetReels",
        builder: (controller) => controller.isLoadingReels
            ? Shimmers.reelsView()
            : controller.mainReels.isEmpty
                ? Text("No Data Found")
                : PreloadPageView.builder(
                    controller: controller.preloadPageController,
                    itemCount: controller.mainReels.length,
                    preloadPagesCount: 4,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) async {
                      controller.onPagination(value);
                      controller.onChangePage(value);
                    },
                    itemBuilder: (context, index) {
                      return GetBuilder<ReelsController>(
                        id: "onChangePage",
                        builder: (controller) => PreviewReelsView(
                          index: index,
                          currentPageIndex: controller.currentPageIndex,
                        ),
                      );
                    },
                  ),
      ),
      bottomNavigationBar: GetBuilder<ReelsController>(
        id: "onPagination",
        builder: (controller) => Visibility(
          visible: controller.isPaginationLoading,
          child: LinearProgressIndicator(color: Colors.pink),
        ),
      ),
    );
  }
}
