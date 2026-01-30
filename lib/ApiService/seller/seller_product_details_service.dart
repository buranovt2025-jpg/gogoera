import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:era_shop/ApiModel/seller/SellerProductDetailsModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

class SellerProductDetailsApi extends GetxService {
  Future<SellerProductDetailsModel?> sellerProductDetails({
    required String productId,
    required String sellerId,
  }) async {
    final authority = Constant.getApiAuthority();
    var params = {
      "productId": productId,
      "sellerId": sellerId,
    };
    final url = Uri.http(authority, Constant.sellerProductDetails, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );
    log('Seller Product Details Api :: $url STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return SellerProductDetailsModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller product view');
    }
  }
}
