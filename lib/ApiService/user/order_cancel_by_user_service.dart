import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../ApiModel/user/OrderCancelByUserModel.dart';

class OrderCancelByUserService extends GetxService {
  Future<OrderCancelByUserModel> orderCancelByUser({
    required String orderId,
    // required String status,
    required String itemId,
  }) async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      "userId": userId,
      "orderId": orderId,
      "status": "Cancelled",
      "itemId": itemId,
    };
    log("Paramsss :: $params");
    final url = Uri.https(uri, Constant.orderCancelByUser, params);

    log("Url :: $url");

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.patch(url, headers: headers);

    log('Order Cancel By User STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return OrderCancelByUserModel.fromJson(jsonResponse);
    } else {
      throw Exception('Order Cancel By User call failed');
    }
  }
}
