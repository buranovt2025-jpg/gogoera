import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../ApiModel/user/CreateRatingModel.dart';

class CreateRatingService extends GetxService {
  Future<CreateRatingModel> createRating({
    required String productId,
    required String userId,
    required RxDouble rating,
  }) async {String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {'rating': rating.toString(), 'userId': userId, 'productId': productId};

    final url = Uri.https(uri, Constant.ratingAdd, params);

    // final body = jsonEncode({'rating': rating, 'userId': userId, 'productId': productId});

    final headers = {
      'key': Constant.SECRET_KEY,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(url, headers: headers);

    log('Rating Status code :: ${response.statusCode} \nBody :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return CreateRatingModel.fromJson(jsonResponse);
    } else {
      throw Exception('Rating is failed');
    }
  }
}
