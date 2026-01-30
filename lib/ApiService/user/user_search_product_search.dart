import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';

import '../../ApiModel/user/user_search_product_model.dart';
import '../../utiles/api_url.dart';
import 'package:http/http.dart' as http;

class UserSearchProductApi extends GetxService {
  Future<UserSearchProductModel?> userSearchProductDetails({required String productName}) async {
    String uri = Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      'productName': productName,
      "userId": userId,
    };
    // final url = Uri.parse(Constant.BASE_URL + Constant.searchProduct);
    final url = Uri.https(uri, Constant.searchProduct, params);

    log("URL :: $url");
    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(
      url,
      headers: headers,
    );

    log('USER SEARCH PRODUCT API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return UserSearchProductModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200');
    }
  }
}
