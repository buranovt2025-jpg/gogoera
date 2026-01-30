import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../ApiModel/user/CreateOrderByUserModel.dart';

class CreateOrderByUserApi extends GetxService {
  Future<CreateOrderByUserModel> createOrderByUserApi({
    required String paymentGateway,
    required String promoCode,
    required double finalTotal,
  }) async {String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      "userId": userId,
      "paymentGateway": paymentGateway,
    };
    final url = Uri.https(uri, Constant.createOrderByUser, params);

    final body = jsonEncode({
      'promoCode': promoCode,
      'finalTotal': finalTotal,
    });

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(url, headers: headers, body: body);

    log('Create Order By User Status code :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return CreateOrderByUserModel.fromJson(jsonResponse);
    } else {
      throw Exception('Create Order failed');
    }
  }
}
