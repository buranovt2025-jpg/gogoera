import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../ApiModel/seller/DeliveredOrderAmountModel.dart';
import 'package:http/http.dart' as http;
import '../../utiles/api_url.dart';
import '../../utiles/globle_veriables.dart';

class DeliveredOrderAmountService extends GetxService {
  Future<DeliveredOrderAmountModel?> sellerWalletReceivedAmountDetails() async {
    final authority = Constant.getApiAuthority();
    var params = {
      "sellerId": sellerId,
    };
    final url = Uri.http(authority, Constant.deliveredOrderAmountForSeller, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );
    log('Seller Wallet Received Details Api URL :: $url STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DeliveredOrderAmountModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 ');
    }
  }
}
