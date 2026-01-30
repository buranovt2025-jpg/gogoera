import 'package:era_shop/ApiModel/seller/SellerLoginModel.dart';
import 'package:era_shop/ApiService/seller/seller_login_service.dart';

import 'package:get/get.dart';

class SellerLoginController extends GetxController {
  SellerLoginModel? sellerLogin;
  var isLoading = true.obs;
  getSellerLoginData({
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
    try {
      isLoading(true);
      var data = await SellerLoginApi().sellerLogin(
          userId: userId,
          businessName: businessName,
          businessTag: businessTag,
          mobileNumber: mobileNumber,
          Email: Email,
          password: password,
          address: address,
          landMark: landMark,
          city: city,
          pinCode: pinCode,
          state: state,
          country: country,
          bankBusinessName: bankBusinessName,
          bankName: bankName,
          accountNumber: accountNumber,
          IFSCCode: IFSCCode,
          branchName: branchName);
      sellerLogin = data;
    } finally {
      isLoading(false);
    }
  }
}
