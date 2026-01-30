import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:era_shop/ApiModel/login/ForgotPasswordModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

class SellerForgotPasswordService extends GetxService {
  Future<ForgotPasswordModel> forgotPassword({
    required String email,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.otpCreate);

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final body = jsonEncode({
      'email': email,
    });
    final response = await http.post(url, body: body, headers: headers);

    log("Create otp response :: ${response.statusCode}");
    log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ForgotPasswordModel.fromJson(jsonResponse);
    } else {
      throw Exception('Email api Failed');
    }
  }
}
