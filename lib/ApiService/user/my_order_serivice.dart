import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/user/MyOrdersModel.dart';
import 'package:http/http.dart' as http;
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

class MyOrderApi extends GetxService {
  Future<MyOrdersModel?> myOrderDetails({
    required String userId,
    required String status,
  }) async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    var params = {
      "userId": userId,
      "status": status,
    };
    final url = Uri.https(uri, Constant.myOrders, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );
    log('GET MY ORDER API Url :: $url \n ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return MyOrdersModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller product view');
    }
  }
}
