import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/seller/ProductCatagory.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class ProductCategoryApi extends GetxService {
  Future<ProductCategory> productCategory() async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      "userId": userId,
    };

    final url = Uri.https(uri, Constant.userProfile, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );


    log('product category :: STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ProductCategory.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller profile whoLogin');
    }
  }
}
