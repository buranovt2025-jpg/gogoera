import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../ApiModel/user/RemoveAllProductFromCartModel.dart';
import '../../utiles/api_url.dart';

class RemoveAllProductFromCartService extends GetxService {
  Future<RemoveAllProductFromCartModel?> removeAllProduct() async {
    final params = {"userId": userId};
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final url = Uri.https(uri, Constant.deleteAllCartProduct, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.delete(url, headers: headers);
    log('Remove all product from cart STATUS CODE :: ${response.statusCode} Url :: $url  \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return RemoveAllProductFromCartModel.fromJson(jsonResponse);
    } else {
      throw Exception('Remove all product from cart');
    }
  }
}
