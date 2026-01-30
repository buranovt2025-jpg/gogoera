import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../ApiModel/seller/ChangePasswordBySellerModel.dart';

class SellerUpdatePasswordService extends GetxService {
  Future<ChangePasswordBySellerModel> updatePasswordApi({
    required String oldPass,
    required String newPass,
    required String confirmPass,
  }) async {
    final authority = Constant.getApiAuthority();
    var params = {"sellerId": sellerId};

    final url = Uri.http(authority, Constant.updatePasswordBySeller, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = json.encode({
      "oldPass": oldPass,
      "newPass": newPass,
      "confirmPass": confirmPass,
    });
    final response = await http.patch(url, headers: headers, body: body);

    log('Update Password URL :: $url \n API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ChangePasswordBySellerModel.fromJson(jsonResponse);
    } else {
      throw Exception('Seller Update password failed');
    }
  }
}
