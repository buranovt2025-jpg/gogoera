import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../ApiModel/seller/SellerAllWalletAmountCountModel.dart';
import '../../utiles/api_url.dart';
import '../../utiles/globle_veriables.dart';

class SellerAllWalletAmountCountApi extends GetxService {
  Future<SellerAllWalletAmountCountModel?> sellerAllWalletAmountCountDetails() async {
    final authority = Constant.getApiAuthority();
    var params = {
      "sellerId": sellerId,
      // "startDate": startDate,
      // "endDate": endDate,
    };
    final url = Uri.http(authority, Constant.walletCountForSeller, params);

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
      return SellerAllWalletAmountCountModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller product view');
    }
  }
}
