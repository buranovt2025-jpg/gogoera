import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:http/http.dart' as http;
import 'package:era_shop/ApiModel/seller/SellerOrderCountModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

class SellerOrderCountApi extends GetxService{
  Future<SellerMyOrderCountModel?> sellerMyOrderCountDetails({
    // required String sellerId,
    required String startDate,
    required String endDate,
  }) async {
    final authority = Constant.getApiAuthority();
    var params = {
      "sellerId": sellerId,
      "startDate": startDate,
      "endDate": endDate,
    };
    final url = Uri.http(authority, Constant.orderCountForSeller, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );
    log('My Order Count Api URL :: $url STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return SellerMyOrderCountModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller product view');
    }
  }
}