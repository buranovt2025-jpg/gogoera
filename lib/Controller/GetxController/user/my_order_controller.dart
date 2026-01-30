import 'dart:developer';
import 'package:era_shop/ApiModel/user/MyOrdersModel.dart';
import 'package:era_shop/ApiService/user/my_order_serivice.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController {
  MyOrdersModel? myOrdersData;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  late final TabController orderTabController;

  getProductDetails({String? selectCategory}) async {
    final tabIndex = orderTabController.index;
    try {
      log("tabIndex :: $tabIndex");
      log("userId :: $userId");
      isLoading = true;
      var data = await MyOrderApi().myOrderDetails(
        userId: userId,
        status: tabIndex == 0
            ? "All"
            : tabIndex == 1
                ? "Pending"
                : tabIndex == 2
                    ? "Confirmed"
                    : tabIndex == 3
                        ? "Out Of Delivery"
                        : tabIndex == 4
                            ? "Delivered"
                            : tabIndex == 5
                                ? "Cancelled"
                                : "",
      );
      myOrdersData = data;
    } finally {
      isLoading = false;
      log('Seller product details finally');
    }
  }
}
