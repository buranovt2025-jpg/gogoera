import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:era_shop/ApiModel/login/VerifyOtpModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

class EnterOtpApi extends GetxService {
  Future<VerifyOtpModel?> enterOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.otpVerify);

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final body = jsonEncode({
      'email': email,
      'otp': otp,
    });

    final response = await http.post(url, headers: headers, body: body);

    log("Enter OTP Status code :: ${response.statusCode}");

    log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return VerifyOtpModel.fromJson(jsonResponse);
    } else {
      throw Exception('Otp api Failed');
    }
  }
}
