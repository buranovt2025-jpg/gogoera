import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

import '../../ApiModel/seller/ShowUploadedReelsModel.dart';

class ShowUploadedReelsApi extends GetxService {
  Future<ShowUploadedReelsModel> showUploadedReels({
    required String start,
    required String limit,
  }) async {
    final authority = Constant.getApiAuthority();
    var params = {
      "start": start,
      "limit": limit,
      "sellerId": sellerId,
    };
    final url = Uri.http(authority, Constant.sellerUploadedShort, params);

    log('URL :: $url');

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );
    log('Show Uploaded shorts Api :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ShowUploadedReelsModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200');
    }
  }
}
