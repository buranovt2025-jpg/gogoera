import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../ApiModel/user/GetFilterwiseProductModel.dart';

class GetFilterWiseProductService extends GetxService {
  Future<GetFilterwiseProductModel> applyFilter({
    required String category,
    required String subCategory,
    required int minPrice,
    required int maxPrice,
  }) async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      "userId": userId,
    };

    final url = Uri.https(uri, Constant.filterWiseProduct, params);

    final body =
        jsonEncode({"category": category, "subCategory": subCategory, "minPrice": minPrice, "maxPrice": maxPrice});

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(url, headers: headers, body: body);

    log('Filter Wise Product API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return GetFilterwiseProductModel.fromJson(jsonResponse);
    } else {
      throw Exception('Filter Wise Product is failed');
    }
  }
}
