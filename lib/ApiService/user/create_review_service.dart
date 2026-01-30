import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/user/CreateReviewModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReviewApi extends GetxService {
  Future<CreateReviewModel> enterReview({
    required String review,
    required String userId,
    required String productId,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.reviewCreate);

    final body = jsonEncode({'review': review, 'userId': userId, 'productId': productId});

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(url, headers: headers, body: body);

    log('Review Status code :: ${response.statusCode} Body :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return CreateReviewModel.fromJson(jsonResponse);
    } else {
      throw Exception('Review is failed');
    }
  }
}
