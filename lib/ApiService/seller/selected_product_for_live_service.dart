import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/seller/SelectedProductForLiveModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SelectedProductForLiveApi extends GetxService {
  Future<SelectedProductForLiveModel?> selectedProduct() async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      "sellerId": sellerId,
    };
    final url = Uri.https(uri, Constant.selectedProductForLive, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    log('Selected product for live :: STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return SelectedProductForLiveModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller product select for live selling');
    }
  }
}
