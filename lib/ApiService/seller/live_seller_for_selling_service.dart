import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import '../../ApiModel/seller/LiveSellerForSellingModel.dart';
import '../../utiles/globle_veriables.dart';

class LiveSellerForSellingApi extends GetxService {
  Future<LiveSellerForSellingModel> sellerLiveForSellingApi() async {
    final url = Uri.parse(Constant.BASE_URL + Constant.liveSeller);

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final body = jsonEncode({
      'sellerId': sellerId,
    });
    final response = await http.post(url, body: body, headers: headers);

    log("Live Seller For Selling Api :: Status code :: ${response.statusCode} \n Response Body :: ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return LiveSellerForSellingModel.fromJson(jsonResponse);
    } else {
      throw Exception('Live Seller For Selling Api Failed');
    }
  }
}
