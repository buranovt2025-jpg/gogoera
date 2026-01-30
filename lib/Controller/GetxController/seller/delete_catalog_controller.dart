import 'dart:developer';
import 'package:era_shop/ApiModel/seller/DeleteCatalogBySellerModel.dart';
import 'package:era_shop/ApiService/seller/delete_catalog_api.dart';
import 'package:era_shop/View/MyApp/Seller/SellerProfile/seller_catalog_screen.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:get/get.dart';

class DeleteCatalogController extends GetxController {
  DeleteCatalogBySellerModel? deleteCatalogBySeller;
  RxBool isLoading = true.obs;

  getDeleteData() async {
    try {
      displayToast(message: St.pleaseWaitToast.tr);
      isLoading(true);
      var data = await DeleteCatalogApi().deleteCatalog(productId: productId);
      deleteCatalogBySeller = data;
      if (deleteCatalogBySeller!.status == true) {
        displayToast(message: "Catalog Delete Successfully");
        Get.off(const SellerCatalogScreen(), transition: Transition.leftToRight);
      } else {
        displayToast(message: St.somethingWentWrong.tr);
      }
    } finally {
      isLoading(false);
      log('Delete Catalog finally');
    }
  }
}
