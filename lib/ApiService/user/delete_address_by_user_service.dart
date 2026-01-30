import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../ApiModel/user/DeleteAddressByUserModel.dart';

class DeleteAddressByUserService extends GetxService {
  Future<DeleteAddressByUserModel?> deleteAddress({
    required String addressId,
  }) async {
    try {
      String uri= Constant.getDomainFromURL(Constant.BASE_URL);
      final params = {
        "userId": userId,
        "addressId": addressId,
      };
      log("User id :: $userId");
      final url = Uri.https(uri, Constant.addressDeleteByUser, params);

      final headers = {
        'key': Constant.SECRET_KEY,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.delete(url, headers: headers);

      log('Address Delete API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return DeleteAddressByUserModel.fromJson(jsonResponse);
      } else {
        throw Exception('Address Delete status is not 200');
      }
    } finally {
      log("Address Delete");
    }
  }
}
