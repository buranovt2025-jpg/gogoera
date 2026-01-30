import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../ApiModel/user/GetLiveSellerListModel.dart';

class LiveSellerListService extends GetxService {
  Future<GetLiveSellerListModel?> getLiveSellerList({
    required String start,
    required String limit,
  }) async {
    try {
      final authority = Constant.getApiAuthority();
      var params = {
        "start": start,
        "limit": limit,
      };
      final url = Uri.http(authority, Constant.liveSellerList, params);

      final headers = {
        'key': Constant.SECRET_KEY,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.get(url, headers: headers);

      log('Get Live Seller List STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return GetLiveSellerListModel.fromJson(jsonResponse);
      } else {
        throw Exception('Status code is not 200');
      }
    } finally {
      log("Get Live Seller List Finally");
    }
  }
}
