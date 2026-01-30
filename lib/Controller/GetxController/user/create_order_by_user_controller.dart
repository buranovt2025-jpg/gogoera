import 'dart:developer';

import 'package:get/get.dart';

import '../../../ApiModel/user/CreateOrderByUserModel.dart';
import '../../../ApiService/user/create_order_by_user_service.dart';

class CreateOrderByUserController extends GetxController {
  RxBool isLoading = false.obs;
  bool isPromoApplied = false;
  double finalAmount = 0;

  CreateOrderByUserModel? createOrderByUserModel;
  RxString? promoCode = "".obs;

  postOrderData({
    required String paymentGateway,
    required String promoCode,
    required double finalTotal,
  }) async {
    try {
      isLoading(true);
      var data = await CreateOrderByUserApi()
          .createOrderByUserApi(paymentGateway: paymentGateway, promoCode: promoCode, finalTotal: finalTotal);
      createOrderByUserModel = data;
    } catch (e) {
      log('Check Out : $e');
    } finally {
      isLoading(false);
      log('Check Out Api Response');
    }
  }
}
