import 'dart:developer';
import 'package:era_shop/ApiModel/login/LoginModel.dart';
import 'package:era_shop/ApiService/login/login_service.dart';
import 'package:era_shop/Controller/ApiControllers/seller/api_seller_data_controller.dart';
import 'package:era_shop/utiles/Theme/theme_service.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginModel? userLogin;
  var isLoading = true.obs;

  getLoginData({
    String? image,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int loginType,
    required String fcmToken,
    required String identity,
  }) async {
    try {
      SellerDataController sellerDataController = Get.put(SellerDataController());
      isLoading(true);
      var data = await LoginApi().login(
        image: image,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        loginType: loginType,
        fcmToken: fcmToken,
        identity: identity,
      );
      userLogin = data;
      if (userLogin!.status == true) {
        userId = userLogin!.user!.id.toString();
        getStorage.write("userId", userId);
        log("UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUser Id $userId");
        //-------------------------------------------
        editImage = userLogin!.user!.image.toString();
        editFirstName = userLogin!.user!.firstName.toString();
        editLastName = userLogin!.user!.lastName.toString();
        editEmail = userLogin!.user!.email.toString();
        editDateOfBirth = userLogin!.user!.dob.toString();
        genderSelect = userLogin!.user!.gender.toString();
        editLocation = userLogin!.user!.location.toString();
        uniqueID = userLogin!.user!.uniqueId.toString();
        if (userLogin!.user!.isSeller == true) {
          becomeSeller = true;
          sellerDataController.getSellerAllData();
        }
        //-------------------------------------------
        getStorage.write("editImage", editImage);
        getStorage.write("editFirstName", editFirstName);
        getStorage.write("editLastName", editLastName);
        getStorage.write("editEmail", editEmail);
        getStorage.write("dob", editDateOfBirth);
        getStorage.write("genderSelect", genderSelect);
        getStorage.write("location", editLocation);
        getStorage.write("uniqueID", uniqueID);
        update();
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
