import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/seller/GetReelsForUserModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:http/http.dart' as http;


class FetchReelsApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<GetReelsForUserModel?> callApi({required String loginUserId}) async {
    log("Get Reels Api Calling... ");

    startPagination += 1;

    log("Get Reels Pagination Page => $startPagination");

    final uri = Uri.parse(
        "${Constant.BASE_URL+Constant.getShortForUser}?start=$startPagination&limit=$limitPagination&userId=$loginUserId");


    final headers = {"key": Constant.SECRET_KEY};


    log("**************** ${uri} ******* ${headers}");

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        log("Get Reels Api Response => ${response.body}");
        return GetReelsForUserModel.fromJson(jsonResponse);
      } else {
        log("Get Reels Api StateCode Error");
      }
    } catch (error) {
      log("Get Reels Api Error => $error");
    }
    return null;
  }
}
