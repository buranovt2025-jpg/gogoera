import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import '../../ApiModel/socket model/user_get_selected_product_model.dart';

class UserGetSelectedProductService extends GetxService {
  Future<UserGetSelectedProductModel> selectedProducts({
    required String roomId,
  }) async {
    final authority = Constant.getApiAuthority();
    final params = {"liveSellingHistoryId": roomId};

    final url = Uri.http(authority, Constant.getSelectedProductForUser, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final response = await http.get(url, headers: headers);

    log("Get live selling data Api :: Status code :: ${response.statusCode} \n Response Body :: ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return UserGetSelectedProductModel.fromJson(jsonResponse);
    } else {
      throw Exception('Get live selling data Api Failed');
    }
  }
}
