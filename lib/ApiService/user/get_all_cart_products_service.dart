import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/ApiModel/user/GetAllCartProductsModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetAllCartProductApi extends GetxService {
  Future<GetAllCartProductsModel?> getAllCartProductDetails({
    required String userId,
  }) async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    var params = {
      "userId": userId,
    };

    final url = Uri.https(uri, Constant.getAllCartProducts, params);
    log("URL :: $url");

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    log('Get All Cart Products  API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return GetAllCartProductsModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200');
    }
  }
}
