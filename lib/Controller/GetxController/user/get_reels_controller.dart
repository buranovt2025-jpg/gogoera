import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:preload_page_view/preload_page_view.dart';
import '../../../ApiModel/seller/GetReelsForUserModel.dart';
import '../../../ApiModel/user/ReelsLikeDislikeByUserModel.dart';
import '../../../utiles/api_url.dart';
import '../../../utiles/show_toast.dart';

class GetReelsForUserController extends GetxController {
  GetReelsForUserModel? getReelsForUser;
  ReelsLikeDislikeByUserModel? reelsLikeDislike;
  PreloadPageController preloadPageController= PreloadPageController();
  int currentPageIndex = 0;

  //----------------------------------------------------------
  PageController pageController = PageController();
  int start = 1;
  int limit = 14;
  void onChangePage(int index) async {
    currentPageIndex = index;
    update();
  }

  RxBool showLikeIcon = false.obs;
  RxBool isTextExpanded = false.obs;

  List likeDislikes = [];
  List<int?> likeCounts = [];

  List<Reel> allReels = [];

  RxBool isLoading = false.obs;
  RxBool moreLoading = false.obs;
  RxBool loadOrNot = true.obs;

  getAllReels() async {
    try {
      isLoading(true);
      loadOrNot(true);
      final authority = Constant.getApiAuthority();
      var params = {"start": "$start", "limit": "$limit", "userId": userId};
      final url = Uri.http(authority, Constant.getShortForUser, params);



      log("Short Url :: $url");

      final headers = {
        'key': Constant.SECRET_KEY,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      log('Short Response Api :: ${response.statusCode} \n RESPONSE :: ${response.body}');

      if (response.statusCode == 200) {
        likeDislikes.clear();
        likeCounts.clear();
        final jsonResponse = json.decode(response.body);
        getReelsForUser = GetReelsForUserModel.fromJson(jsonResponse);
        final reelsList = getReelsForUser?.reels ?? [];

        allReels.addAll(reelsList);

        for (int i = 0; i < reelsList.length; i++) {
          likeDislikes.add(reelsList[i].isLike);
          likeCounts.add((reelsList[i].like ?? 0).toInt());
        }

        if (allReels.isEmpty) {
          loadOrNot(false);
        }
        start++;
        update();
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      Exception("API error is :: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Use when shorts pagination
  reelsPagination() async {
    try {
      moreLoading(true);
      loadOrNot(true);
      final authority = Constant.getApiAuthority();
      var params = {"start": "$start", "limit": "$limit", "userId": userId};
      final url = Uri.http(authority, Constant.getShortForUser, params);
      log("Short Url :: $url");

      final headers = {
        'key': Constant.SECRET_KEY,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      log('Short Response Api :: ${response.statusCode} \n RESPONSE :: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        getReelsForUser = GetReelsForUserModel.fromJson(jsonResponse);
        final reelsList = getReelsForUser?.reels ?? [];

        allReels.addAll(reelsList);

        for (int i = 0; i < reelsList.length; i++) {
          likeDislikes.add(reelsList[i].isLike);
          likeCounts.add((reelsList[i].like ?? 0).toInt());
        }
        if (reelsList.isEmpty) {
          loadOrNot(false);
          displayToast(message: "No more shorts!");
        } else {
          start++;
          update();
        }
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      Exception("API error is :: $e");
    } finally {
      moreLoading(false);
    }
  }

  likeAndDislikeByUser({required String reelId}) async {
    try {
      final authority = Constant.getApiAuthority();
      var params = {"userId": userId, "reelId": reelId};
      final url = Uri.http(authority, Constant.shortsLikeAndDislike, params);

      log('URL :: $url');

      final headers = {
        'key': Constant.SECRET_KEY,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.post(
        url,
        headers: headers,
      );

      log('Short Like and dislike Response Api :: ${response.statusCode} \n RESPONSE :: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        reelsLikeDislike = ReelsLikeDislikeByUserModel.fromJson(jsonResponse);
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      Exception("API error is :: $e");
    } finally {}
  }
}
