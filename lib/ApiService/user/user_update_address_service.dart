import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/ApiModel/user/UserAddAddressModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utiles/globle_veriables.dart';

class UserUpdateAddressApi extends GetxService {
  Future<UserAddAddressModel> userUpdateAddress({
    required String userId,
    required String name,
    required String country,
    required String state,
    required String city,
    required String zipCode,
    required String address,
  }) async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    var params = {
      "addressId": addressId,
    };

    final url =
        Uri.https(uri, Constant.userUpdateAddress, params);
    log("url$url");

    final body = jsonEncode({
      'userId': userId,
      'name': name,
      'country': country,
      'state': state,
      'city': city,
      'zipCode': zipCode,
      'address': address,
    });

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    log("update address:$body");
    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      log("respinse:$jsonResponse");
      return UserAddAddressModel.fromJson(jsonResponse);
    } else {
      throw Exception('User Update Address is failed');
    }
  }
}
