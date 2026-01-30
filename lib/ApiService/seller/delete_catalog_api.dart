import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/ApiModel/seller/DeleteCatalogBySellerModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteCatalogApi extends GetxService {
  Future<DeleteCatalogBySellerModel?> deleteCatalog({
    required String productId,
  }) async {
    String uri= Constant.getDomainFromURL(Constant.BASE_URL);
    final params = {
      "productId": productId,
    };

    final url = Uri.https(uri, Constant.sellerProductDelete, params);

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final response = await http.delete(url, headers: headers);
    log('Delete Catalog Api :: STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      // Handle success response
      final jsonResponse = json.decode(response.body);
      return DeleteCatalogBySellerModel.fromJson(jsonResponse);
    } else {
      // Handle error response
      log('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
    return null;
  }
}
