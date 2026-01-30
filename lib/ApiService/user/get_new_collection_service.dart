import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/ApiModel/user/GetNewCollectionModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetNewCollectionApi extends GetxService {
  Future<GetNewCollectionModel?> showCategory() async {
    final authority = Constant.getApiAuthority();
    final params = {"userId": userId};
    final url = Uri.http(authority, Constant.newCollection, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: headers);

    log('New Collection Api STATUS CODE :: ${response.statusCode} Url :: $url  \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return GetNewCollectionModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200');
    }
  }
}
