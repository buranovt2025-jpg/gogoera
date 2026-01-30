import 'dart:developer';
import 'package:era_shop/ApiModel/seller/ShowCatalogModel.dart';
import 'package:era_shop/ApiService/seller/show_catalog_service.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:get/get.dart';


class ShowCatalogController extends GetxController {
  ShowCatalogModel? showCatalogData;
  RxBool isLoading = true.obs;
  RxBool moreLoading = false.obs;
  RxBool loadOrNot = true.obs;

  int start = 1;
  int limit = 14;

  List<Products> catalogItems = [];
  List<Products> catalogItemsForLive = [];
  List selectedCatalogId = [];

  Future getCatalogData() async {
    try {
      isLoading(true);
      loadOrNot(true);
      var data = await ShowCatalogApi().showCatalogs(start: "$start", limit: "$limit");
      showCatalogData = data;
      catalogItems.clear();
      if (showCatalogData!.status == true) {
        catalogItems.addAll(showCatalogData!.products!);
        start++;
        update();
      }
      if (showCatalogData!.products!.isEmpty) {
        loadOrNot(false);
      }
    } finally {
      isLoading(false);
      log('Show catalog finally');
    }
  }

  Future loadMoreData() async {
    try {
      moreLoading(true);
      loadOrNot(true);
      var data = await ShowCatalogApi().showCatalogs(
        start: "$start",
        limit: "$limit",
      );
      if (data.status == true) {
        catalogItems.addAll(data.products!);
        start++;
        update();
      }
      if (data.products!.isEmpty) {
        loadOrNot(false);
        displayToast(message: "No more products");
      }
    } finally {
      moreLoading(false);
      log('Load more data finally');
    }
  }

/*  Future getCatalogDataForLive() async {
    try {
      isLoading(true);
      var data = await ShowCatalogApi().showCatalogs(start: "1", limit: "30");
      showCatalogData = data;
      catalogItemsForLive.clear();
      if (showCatalogData!.status == true) {
        catalogItemsForLive.addAll(showCatalogData!.products!);
        update();
      }
    } finally {
      isLoading(false);
      log('Show catalog finally');
    }
  }*/
}
