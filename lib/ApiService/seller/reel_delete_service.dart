import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../ApiModel/seller/ReelDeleteModel.dart';

class ReelDeleteService extends GetxService {
  Future<ReelDeleteModel?> deleteReel({
    required String reelId,
  }) async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      "reelId": reelId,
    };

    final url = Uri.https(uri, Constant.sellerReelDelete, params);

    log("URL :: $url");

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final response = await http.delete(url, headers: headers);
    log('Delete Reel Api :: STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ReelDeleteModel.fromJson(jsonResponse);
    } else {
      log('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
    return null;
  }
}
