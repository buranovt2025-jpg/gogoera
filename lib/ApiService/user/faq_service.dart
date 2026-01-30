import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../ApiModel/user/FAQModel.dart';
import '../../utiles/api_url.dart';

class FAQApi extends GetxService {
  Future<FaqModel?> showFAQ() async {
    try {
      final authority = Constant.getApiAuthority();
      final headers = {
        'key': Constant.SECRET_KEY,
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final url = Uri.http(authority, Constant.faq);

      final response = await http.get(url, headers: headers);

      log('FAQ API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FaqModel.fromJson(jsonResponse);
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      log("FAQ :: $e");
    }
    return null;
  }
}
