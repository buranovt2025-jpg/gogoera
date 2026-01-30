import 'dart:developer';

import 'package:era_shop/ApiModel/user/AddProductToCartModel.dart';
import 'package:era_shop/ApiService/user/add_product_to_cart_service.dart';
import 'package:era_shop/Controller/GetxController/user/remove_all_product_from_cart_controller.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utiles/Theme/my_colors.dart';

class AddProductToCartController extends GetxController {
  AddProductToCartModel? addProductToCart;
  RxBool isLoading = false.obs;
  RxBool userAddProLoading = false.obs;

  RxBool isAddToCart = false.obs;
  Map<String, String> selectedValues = {};

  Future addProductToCartData({required int productQuantity, required List<dynamic> attributes}) async {
    try {
      isLoading(true);
      log("Controller :::: userId :: $userId \n productId :: $productId \n productQuantity :: $productQuantity \n attributesArray :: $attributes");

      var data = await AddProductToCartApi().addProductToCart(
        userId: userId,
        productId: productId,
        productQuantity: productQuantity,
        attributes: attributes,
      );
      addProductToCart = data;
      if (addProductToCart?.status == true) {
        isAddToCart(true);
      }
    } catch (e) {
      log('ADD PRODUCT TO CART: $e');
    } finally {
      isLoading(false);
      log('ADD PRODUCT TO CART Api Response');
    }
  }

  addToCartWhenLive() {
    List<Map<String, String>> attributesArray = selectedValues.entries.map((entry) {
      return {
        "name": entry.key,
        "value": entry.value,
      };
    }).toList();

    addToCart(
      productQuantity: 1,
      attributes: attributesArray,
    );
  }

  addToCart({required int productQuantity, required List<dynamic> attributes}) async {
    RemoveAllProductFromCartController removeAllProductFromCartController =
        Get.put(RemoveAllProductFromCartController());

    try {
      userAddProLoading(true);
      log("addToCartWhenLive :::: userId :: $userId \n productId :: $productId \n productQuantity :: $productQuantity \n attributesArray :: $selectedValues");

      var data = await AddProductToCartApi().addProductToCart(
        userId: userId,
        productId: productId,
        productQuantity: productQuantity,
        attributes: attributes,
      );
      addProductToCart = data;
      if (addProductToCart!.status == true) {
        Get.dialog(Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: MyColors.primaryPink,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Add to Cart",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ),
                Image.asset("assets/icons/add-to-shopping-cart2.png", height: 200).paddingSymmetric(vertical: 8),
                Text(
                  "Your product added to cart successfully!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: MyColors.darkGrey,
                  ),
                ).paddingSymmetric(horizontal: 15),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: Get.width / 2,
                    decoration:
                        BoxDecoration(color: MyColors.primaryPink, borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: GoogleFonts.plusJakartaSans(
                            color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ).paddingSymmetric(vertical: 15)
              ],
            ),
          ),
        ));
      } else {
        Get.dialog(Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: MyColors.primaryPink,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Add to Cart",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ),
                Image.asset("assets/icons/add-to-shopping-cart2.png", height: 200).paddingSymmetric(vertical: 8),
                Text(
                  "Only one seller's products added to cart at a time,can we remove it!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: MyColors.darkGrey,
                  ),
                ).paddingSymmetric(horizontal: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => removeAllProductFromCartController
                          .deleteAllCartProduct()
                          .then((value) => Get.back())
                          .then((value) => addToCartWhenLive()),
                      child: Container(
                        height: 50,
                        width: Get.width / 3,
                        decoration:
                            BoxDecoration(color: MyColors.primaryPink, borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Text(
                            "Remove",
                            style: GoogleFonts.plusJakartaSans(
                                color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ).paddingOnly(right: 13),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: Get.width / 3,
                        decoration:
                            BoxDecoration(color: MyColors.primaryPink, borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.plusJakartaSans(
                                color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(vertical: 15)
              ],
            ),
          ),
        ));
      }
    } catch (e) {
      log('ADD PRODUCT TO CART: $e');
    } finally {
      userAddProLoading(false);
      log('ADD PRODUCT TO CART Api Response');
    }
  }
}
