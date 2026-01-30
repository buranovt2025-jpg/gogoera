import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/ApiModel/user/FavoriteItemsModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FavoriteItemApi extends GetxService {
  Future<FavoriteItemsModel?> showFavoriteItem() async {
    try {
      String uri= Constant.getDomainFromURL(Constant.BASE_URL);
      final params = {
        "userId": userId,
        // "categoryId": categoryId,
      };

      final url = Uri.https(uri, Constant.favoriteProducts, params);

      final headers = {
        'key': Constant.SECRET_KEY,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.get(url, headers: headers);

      log('FOLLOW/UNFOLLOW API STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FavoriteItemsModel.fromJson(jsonResponse);
      } else {
        throw Exception('Status code is not 200');
      }
    } finally {
      log("message");
    }
  }
}
