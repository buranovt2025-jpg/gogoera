import 'package:era_shop/ApiModel/user/GalleryCategoryModel.dart';
import 'package:era_shop/ApiService/user/gallery_catagory_service.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';

import '../../../utiles/show_toast.dart';

class GalleryCategoryController extends GetxController {
  GalleryCategoryModel? galleryCategory;
  RxBool isLoading = true.obs;
  RxBool moreLoading = false.obs;

  int start = 1;
  int limit = 12;
  List<Product> galleryProducts = [];

  getCategoryData({String? selectCategory}) async {
    try {
      isLoading(true);
      galleryProducts.clear();
      start = 1;

      var data = await GalleryCategoryApi().showCategory(
        userId: userId,
        categoryId: selectCategory.toString(),
        start: "$start",
        limit: "$limit",
      );
      galleryCategory = data;

      if (galleryCategory!.status == true) {
        galleryProducts.clear();
        galleryProducts.addAll(data!.product!.toList());
        start++;
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  Future loadMoreData({String? selectCategory}) async {
    try {
      moreLoading(true);
      var data = await GalleryCategoryApi()
          .showCategory(userId: userId, categoryId: selectCategory.toString(), start: "$start", limit: "$limit");
      galleryCategory = data;

      if (data!.status == true) {
        galleryProducts.addAll(data.product!);
        start++;
        update();
      }
      if (data.product!.isEmpty) {
        displayToast(message: "No more products");
      }
    } finally {
      moreLoading(false);
    }
  }
}
