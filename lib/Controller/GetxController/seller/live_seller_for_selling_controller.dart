import 'dart:developer';

import 'package:get/get.dart';

import '../../../ApiModel/seller/LiveSellerForSellingModel.dart';
import '../../../ApiService/seller/live_seller_for_selling_service.dart';

class LiveSellerForSellingController extends GetxController {
  LiveSellerForSellingModel? liveSellerForSelling;
  RxBool isLoading = false.obs;

  List<SelectedProducts> sellerSelectedProducts = [];

  sellerLiveForSelling() async {
    try {
      isLoading(true);
      sellerSelectedProducts.clear();
      var data = await LiveSellerForSellingApi().sellerLiveForSellingApi();
      liveSellerForSelling = data;
      sellerSelectedProducts.addAll(liveSellerForSelling!.liveseller!.selectedProducts!);
    } catch (e) {
      log('Live Seller For Selling Controller :: $e');
    } finally {
      isLoading(false);
      log('finally ${liveSellerForSelling?.message}');
    }
  }
}
