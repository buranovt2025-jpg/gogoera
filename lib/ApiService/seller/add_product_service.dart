import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:era_shop/ApiModel/seller/AddProductModel.dart';
import 'package:era_shop/Controller/GetxController/seller/add_product_controller.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddProductApi extends GetxService {
  AddProductController addProductController = Get.put(AddProductController());
  Future<AddProductModel> addProduct({
    required String sellerId,
    required File mainImage,
    required List<File> images,
    required String productName,
    required String price,
    required String category,
    required String subCategory,
    required String shippingCharges,
    required String description,
    required String productCode,
    required List<Map<String, dynamic>> attributes,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.createProduct);
    var request = http.MultipartRequest("POST", url);

    if (mainImage.isBlank == true) {
      log("IMAGE NULL");
    } else {
      log("Images :: $images");
      for (int i = 0; i < images.length; i++) {
        var addImages = await http.MultipartFile.fromPath('images', images[i].path);
        request.files.add(addImages);
      }
      log("Images path :: ${mainImage.path}");
      var addImage = await http.MultipartFile.fromPath('mainImage', mainImage.path);
      request.files.add(addImage);
    }

    request.headers.addAll({
      "key": Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    });

    Map<String, String> body = {
      'sellerId': sellerId,
      'productName': productName,
      'price': price,
      'category': category,
      'subCategory': subCategory,
      'shippingCharges': shippingCharges,
      'description': description,
      'productCode': productCode,
      'attributes': json.encode(attributes),
    };

    // List<MapEntry<String, dynamic>> selectedValuesList =
    //     selectedValuesByType.entries.map((entry) => MapEntry(entry.key, entry.value.join(','))).toList();
    //
    // for (var entry in selectedValuesList) {
    //   request.fields[entry.key] = entry.value;
    //   log("Selected value List :: ${entry.value}");
    // }

    request.fields.addAll(body);
    var res1 = await request.send();
    var response = await http.Response.fromStream(res1);

    log('Product add By Seller :: STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return AddProductModel.fromJson(jsonResponse);
    } else {
      throw Exception('Add Product failed');
    }
  }
}
