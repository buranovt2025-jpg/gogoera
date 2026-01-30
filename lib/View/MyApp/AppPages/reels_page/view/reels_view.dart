import 'package:era_shop/View/MyApp/AppPages/reels_page/controller/reels_controller.dart';
import 'package:era_shop/View/MyApp/AppPages/reels_page/widget/reels_widget.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final ReelsController controller = Get.find<ReelsController>();
  bool _initCalled = false;

  @override
  void initState() {
    super.initState();
    if (!_initCalled) {
      _initCalled = true;
      controller.init();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_library_outlined, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            "Нет рилсов",
                            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Пока здесь пусто",
                            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  )
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
                      if (index >= controller.mainReels.length) return const SizedBox.shrink();
                      return GetBuilder<ReelsController>(
                        id: "onChangePage",
                        builder: (ctrl) => PreviewReelsView(
                          index: index,
                          currentPageIndex: ctrl.currentPageIndex,
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
