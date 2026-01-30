import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/login/LoginModel.dart';
import 'package:era_shop/utiles/Theme/theme_service.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class LoginApi extends GetxService {
  Future<LoginModel> login({
    String? image,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int loginType,
    required String fcmToken,
    required String identity,
  }) async {
    log("image :: $image");
    log("firstName :: $firstName");
    log("lastName :: $lastName");
    log("email :: $email");
    log("password :: $password");
    log("loginType :: $loginType");
    log("fcmToken :: $fcmToken");
    log("identity :: $identity");
    final url = Uri.parse(Constant.BASE_URL + Constant.userLogin);
    log("url ::: $url");
    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };
    final body = jsonEncode({
      'image': image,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'loginType': loginType,
      'fcmToken': fcmToken,
      'identity': identity,
    });

    final response = await http.post(url, headers: headers, body: body);
    log("Login Api Status code :- ${response.statusCode} \n Body response :- ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["status"] == true) {
        getStorage.write("isLogin", true);
      }
      return LoginModel.fromJson(jsonResponse);
    } else {
      throw Exception('Login Failed');
    }
  }
}
