import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../ApiModel/seller/PendingOrderAmountModel.dart';
import '../../utiles/api_url.dart';
import '../../utiles/globle_veriables.dart';
import 'package:http/http.dart' as http;

class SellerWalletPendingAmountApi extends GetxService {
  Future<PendingOrderAmountModel?> sellerWalletPendingAmountDetails() async {
    final authority = Constant.getApiAuthority();
    var params = {
      "sellerId": sellerId,
    };
    final url = Uri.http(authority, Constant.pendingWalletAmountForSeller, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );
    log('Seller Wallet Pending Details Api URL :: $url STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PendingOrderAmountModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 ');
    }
  }
}
