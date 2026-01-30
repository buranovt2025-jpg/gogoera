import 'dart:convert';
import 'dart:developer';

import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:era_shop/ApiModel/user/UserProductDetailsModel.dart';
import 'package:era_shop/ApiService/user/user_product_details_service.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProductDetailsController extends GetxController {
  UserProductDetailsModel? userProductDetails;
  RxBool isLoading = true.obs;
  final TextEditingController sizeSelectController = TextEditingController();

  RxMap<String, List<String>> selectedValuesByType = RxMap<String, List<String>>();
  List<Attributes>? selectedCategoryValues = [];

  List<CoolDropdownItem<String>> categoryDropdownItems = [];

  userProductDetailsData() async {
    try {
      isLoading(true);
      var data = await UserProductDetailsApi().userProductDetails(productId: productId, userId: userId);
      userProductDetails = data;
      if (userProductDetails?.status == true) {
        selectedCategoryValues = userProductDetails!.product![0].attributes;

        log("Json response :: ${jsonEncode(selectedCategoryValues)}");

        for (var categoryValue in selectedCategoryValues!) {
          selectedValuesByType[categoryValue.name.toString()] = List<String>.from(categoryValue.value!.toList());
        }
        log("A aavo data :: $selectedValuesByType");
        update();
      }
    } catch (e) {
      log('New Collection Error: $e');
    } finally {
      isLoading(false);
      log('User Product Details finally');
    }
  }
}
