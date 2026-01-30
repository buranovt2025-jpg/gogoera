import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:era_shop/ApiModel/seller/SellerLoginModel.dart';
import 'package:era_shop/utiles/api_url.dart';
import 'package:get/get.dart';

class SellerLoginApi extends GetxService {
  Future<SellerLoginModel?> sellerLogin({
    required String userId,
    required String businessName,
    required String businessTag,
    required String mobileNumber,
    required String Email,
    required String password,
    required String address,
    required String landMark,
    required String city,
    required String pinCode,
    required String state,
    required String country,
    required String bankBusinessName,
    required String bankName,
    required String accountNumber,
    required String IFSCCode,
    required String branchName,
  }) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.requestCreate);

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final body = jsonEncode({
      'userId': userId,
      'businessName': businessName,
      'businessTag': businessTag,
      'mobileNumber': mobileNumber,
      'Email': Email,
      'password': password,
      'address': address,
      'landMark': landMark,
      'city': city,
      'pinCode': pinCode,
      'state': state,
      'country': country,
      'bankBusinessName': bankBusinessName,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'IFSCCode': IFSCCode,
      'branchName': branchName,
    });
    final response = await http.post(url, headers: headers, body: body);

    log('Seller order count :: STATUS CODE :: ${response.statusCode} \n RESPONSE :: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return SellerLoginModel.fromJson(jsonResponse);
    } else {
      throw Exception('Seller Login Failed');
    }
  }
}
