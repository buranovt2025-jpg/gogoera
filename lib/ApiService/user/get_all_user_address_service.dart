import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/ApiModel/user/GetAllUserAddressModel.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utiles/api_url.dart';

class GetAllUserAddressApi extends GetxService {
  Future<GetAllUserAddressModel?> getAllAddress() async {
    final authority = Constant.getApiAuthority();
    final params = {"userId": userId};
    final url = Uri.http(authority, Constant.getAllAddress, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: headers);

    log('Get All User Address Api STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return GetAllUserAddressModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200');
    }
  }
}
