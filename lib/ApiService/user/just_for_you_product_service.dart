import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:http/http.dart' as http;
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

import '../../ApiModel/user/JustForYouProductModel.dart';

class JustForYouApi extends GetxService {
  Future<JustForYouProductModel?> showProduct() async {
    // final url = Uri.parse(Constant.BASE_URL + Constant.justForYouProduct);
    final authority = Constant.getApiAuthority();
    final params = {
      "userId": userId,
    };
    final url = Uri.http(authority, Constant.justForYouProduct, params);
    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: headers);

    log('Just for you Api  url :: ${url}');
    log('Just for you Api :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return JustForYouProductModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200');
    }
  }
}
