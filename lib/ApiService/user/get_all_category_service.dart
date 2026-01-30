import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

import '../../ApiModel/user/GetAllCategoryModel.dart';

class GetAllCategoryApi extends GetxService {
  Future<GetAllCategoryModel?> showCategory() async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final url = Uri.https(uri, Constant.getAllCategory);

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: headers);

    log('Get All Category Api :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return GetAllCategoryModel.fromJson(jsonResponse);
    } else {
      throw Exception('Status code is not 200');
    }
  }
}
