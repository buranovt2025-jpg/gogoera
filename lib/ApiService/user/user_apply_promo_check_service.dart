import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../ApiModel/user/userApplyPromoCheck.dart';
import '../../utiles/globle_veriables.dart';

class UserApplyPromoCheckApi extends GetxService {
  Future<UserApplyPromoCheckModel> userApplyPromoCheck({
    required String promocodeId,
  }) async {final authority = Constant.getApiAuthority();
    final params = {
      "promocodeId": promocodeId,
      "userId": userId,
    };

    log("Promo id :: $promocodeId");
    log("UUUser id :: $userId");
    final url = Uri.http(authority, Constant.userApplyPromoCheck, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(url, headers: headers);

    log('User Apply Promo Check API STATUS CODE ::url  $url ::::::params  $params${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return UserApplyPromoCheckModel.fromJson(jsonResponse);
    } else {
      throw Exception('user Apply Promo Api call failed');
    }
  }
}
