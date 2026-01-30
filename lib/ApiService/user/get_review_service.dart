import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/ApiModel/user/GetReviewModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetReviewApi extends GetxService {
  Future<GetReviewModel?> getReviewDetails({
    required String productId,
  }) async {
    var params = {
      "productId": productId,
    };
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final url = Uri.https(uri, Constant.getReviewDetails, params);

    log("URL :: $url");
    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    log('GET REVIEW API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return GetReviewModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller product view');
    }
  }
}
