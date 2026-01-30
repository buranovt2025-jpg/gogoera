import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

import '../../ApiModel/login/user_sand_otp_model.dart';

class UserVerifyOtpService extends GetxService {
  Future<UserSandOtpModel> sandOtp({
    required String email,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.userLoginVerifyOtp);

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final body = jsonEncode({
      'email': email,
    });
    final response = await http.post(url, body: body, headers: headers);

    log("User verify OTP response :: ${response.statusCode}");
    log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return UserSandOtpModel.fromJson(jsonResponse);
    } else {
      throw Exception('User verify OTP Failed');
    }
  }
}
