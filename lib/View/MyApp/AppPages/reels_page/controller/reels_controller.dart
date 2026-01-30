import 'package:era_shop/ApiModel/seller/GetReelsForUserModel.dart';
import 'package:era_shop/View/MyApp/AppPages/reels_page/api/fetch_reels_api.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class ReelsController extends GetxController {
  PreloadPageController preloadPageController = PreloadPageController();

  bool isLoadingReels = false;
  GetReelsForUserModel? getReelsForUserModel;

  bool isPaginationLoading = false;

  List<Reel> mainReels = [];

  int currentPageIndex = 0;



  Future<void> init() async {
    currentPageIndex = 0;
    mainReels.clear();
    FetchReelsApi.startPagination = 0;
    isLoadingReels = true;
    await onGetReels();
    isLoadingReels = false;
  }

  void onPagination(int value) async {
    if ((mainReels.length - 1) == value) {
      if (isPaginationLoading == false) {
        isPaginationLoading = true;
        update(["onPagination"]);
        await onGetReels();
        isPaginationLoading = false;
        update(["onPagination"]);
      }
    }
  }

  void onChangePage(int index) async {
    currentPageIndex = index;
    update(["onChangePage"]);
  }

  Future<void> onGetReels() async {
    getReelsForUserModel = null;
    getReelsForUserModel = await FetchReelsApi.callApi(loginUserId: userId);


    if (getReelsForUserModel?.reels != null) {
      if (getReelsForUserModel!.reels!.isNotEmpty) {
        mainReels.addAll(getReelsForUserModel?.reels ?? []);
        update(["onGetReels"]);
      }
    }
    if (mainReels.isEmpty) {
      update(["onGetReels"]);
    }
  }
}
