import 'dart:developer';

import 'package:era_shop/ApiModel/user/RemoveProductToCartModel.dart';
import 'package:era_shop/ApiService/user/remove_product_to_cart_service.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';

import '../../../View/MyApp/AppPages/bottom_tab_bar.dart';
import '../../../utiles/show_toast.dart';

class RemoveProductToCartController extends GetxController {
  RemoveProductToCartModel? removeProductToCartModel;
  RxBool isLoading = false.obs;

  Future removeProductToCartData({required int productQuantity, required List<dynamic> attributes, String? attributesId}) async {
    try {
      isLoading(true);
      var data = await RemoveProductToCartApi()
          .removeProductToCart(userId: userId, productId: productId, productQuantity: productQuantity, attributes: attributes);
      removeProductToCartModel = data;
      log("Remove product Status :: ${removeProductToCartModel?.status}");
      if (removeProductToCartModel?.status == true) {
        displayToast(message: "Product Removed").then((value) => Get.offAll(() => BottomTabBar(
              index: 3,
            )));
      } else {
        displayToast(message: "Something Wrong Please Try Again");
      }
    } catch (e) {
      log('REMOVE PRODUCT TO CART: $e');
    } finally {
      isLoading(false);
      log('REMOVE PRODUCT TO CART Api Response');
    }
  }
}
