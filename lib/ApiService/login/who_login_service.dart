import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/login/WhoLoginModel.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class WhoLoginApi extends GetxService {
  Future<WhoLoginModel> whoLogin() async {
   String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      "userId": userId,
    };
    final url = Uri.https(uri, Constant.userProfile, params);

    log("Url :: $url");

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    log('Who login Api StatusCode :: ${response.statusCode}\n Body Response :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return WhoLoginModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200 Seller profile whoLogin');
    }
  }
}
