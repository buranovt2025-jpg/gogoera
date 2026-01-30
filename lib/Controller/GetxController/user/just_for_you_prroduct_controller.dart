import 'dart:developer';

import 'package:get/get.dart';

import '../../../ApiModel/user/JustForYouProductModel.dart';
import '../../../ApiService/user/just_for_you_product_service.dart';

class JustForYouProductController extends GetxController {
  JustForYouProductModel? justForYouProduct;
  RxBool isLoading = true.obs;
  Future getJustForYouProduct() async {
    try {
      isLoading(true);
      var data = await JustForYouApi().showProduct();
      justForYouProduct = data;
    } catch (e) {
      log('New Collection Error: $e');
    } finally {
      isLoading(false);
      log('Get Review Details finally');
    }
  }
}
