import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/user/UserProductDetailsModel.dart';
import 'package:http/http.dart' as http;
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

class UserProductDetailsApi extends GetxService {
  Future<UserProductDetailsModel?> userProductDetails({
    required String productId,
    required String userId,
  }) async {
    final authority = Constant.getApiAuthority();
    var params = {
      "productId": productId,
      "userId": userId,
    };
    final url = Uri.http(authority, Constant.userProductDetails, params);

    log("URL :: $url");
    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    log('USER DETAILS API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return UserProductDetailsModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller product view');
    }
  }
}
