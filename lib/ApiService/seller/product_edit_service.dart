import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:era_shop/ApiModel/seller/ProductEditModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

import '../../utiles/globle_veriables.dart';

class ProductEditApi extends GetxService {
  Future<ProductEditModel?> editProduct({
    required File mainImage,
    required List<File> images,
    required String productCode,
    required String productName,
    required String price,
    required String category,
    required String subCategory,
    required String shippingCharges,
    required String description,
    required List<Map<String, dynamic>> attributes,
  }) async {
    log("Edit Attributes json encode :: ${json.encode(attributes)}");
    log("Product Code Service:: $productCode");
    final authority = Constant.getApiAuthority();
    var params = {
      "productId": productId,
      "sellerId": sellerId,
      "productCode": productCode,
    };

    final url = Uri.http(authority, Constant.updateProductBySeller, params);

    var request = http.MultipartRequest("POST", url);

    if (mainImage.isBlank == true) {
      log("IMAGE NULL");
    } else {
      for (int i = 0; i < images.length; i++) {
        var addImages = await http.MultipartFile.fromPath('images', images[i].path);
        request.files.add(addImages);
      }
      var addImage = await http.MultipartFile.fromPath('mainImage', mainImage.path);
      request.files.add(addImage);
    }

    request.headers.addAll({
      "key": Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    });

    Map<String, String> body = {
      'productName': productName,
      'price': price,
      'category': category,
      'subCategory': subCategory,
      'shippingCharges': shippingCharges,
      'description': description,
      'attributes': json.encode(attributes)
    };

    request.fields.addAll(body);
    var res1 = await request.send();
    var response = await http.Response.fromStream(res1);

    log('Seller edit product :: STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ProductEditModel.fromJson(jsonResponse);
    } else {
      throw Exception('Edit Product failed');
    }
  }
}
