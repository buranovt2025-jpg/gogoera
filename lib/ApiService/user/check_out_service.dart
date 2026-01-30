import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../ApiModel/user/CheckOutModel.dart';
import '../../utiles/api_url.dart';
import 'package:http/http.dart' as http;

class CheckOutApi extends GetxService{
  Future<CheckOutModel> checkOut({
    required String userId,
    required String promoCode,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.checkOut);

    final body = jsonEncode({'userId': userId, 'promoCode': promoCode});

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(url, headers: headers, body: body);

    log('Check Out API URL :: $url STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return CheckOutModel.fromJson(jsonResponse);
    } else {
      throw Exception('Check Out failed');
    }
  }
}