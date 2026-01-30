import 'dart:developer' as log;
import 'dart:io';
import 'dart:math';
import 'package:era_shop/Controller/GetxController/seller/attributes_add_product_controller.dart';
import 'package:era_shop/View/MyApp/Seller/SellerProfile/seller_catalog_screen.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../ApiModel/seller/AddProductModel.dart';
import '../../../ApiService/seller/add_product_service.dart';
import '../../../utiles/show_toast.dart';

class AddProductController extends GetxController {
  AddProductModel? addProduct;
  RxBool isLoading = false.obs;
  AttributesAddProductController attributesAddProductController = Get.put(AttributesAddProductController());

  String generateRandomCode() {
    Random random = Random();
    int min = 100000; // Minimum 6-digit number
    int max = 999999; // Maximum 6-digit number
    int randomNumber = min + random.nextInt(max - min);
    return randomNumber.toString();
  }

  File? productImageXFile;
  List<File> addProductImages = [];
  List<Map<String, dynamic>> attributes = [];

  //--------------------------------------------------------
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController shippingChargeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? category;
  String? subCategory;

  addCatalog() async {
    try {
      isLoading(true);
      if (addProductImages.isEmpty ||
          nameController.text.isEmpty ||
          priceController.text.isEmpty ||
          category!.isEmpty ||
          subCategory!.isEmpty ||
          shippingChargeController.text.isEmpty ||
          descriptionController.text.isEmpty) {
        displayToast(message: "All fields are required \nto be filled");
      } else {
        /// **************** API CALLING *****************\\\
        attributesAddProductController.selectedValuesByType.forEach((key, values) {
          Map<String, dynamic> attribute = {
            'name': key,
            'value': values,
          };
          attributes.add(attribute);
        });
        log.log("Attributes :: $attributes");

        var data = await AddProductApi().addProduct(
            sellerId: sellerId,
            mainImage: addProductImages[0],
            images: addProductImages,
            productName: nameController.text.toString().capitalizeFirst.toString(),
            price: priceController.text,
            category: category.toString(),
            subCategory: subCategory.toString(),
            shippingCharges: shippingChargeController.text,
            description: descriptionController.text,
            attributes: attributes,
            productCode: generateRandomCode());
        addProduct = data;

        if (addProduct!.status == true) {
          displayToast(message: "Catalog add successfully");
          Get.off(const SellerCatalogScreen(), transition: Transition.leftToRight);
          // Get.back();
        } else {
          displayToast(message:St.somethingWentWrong.tr);
        }
      }
    } catch (e) {
      Exception("Add product Error ::  $e");
    } finally {
      isLoading(false);
    }
  }
}
