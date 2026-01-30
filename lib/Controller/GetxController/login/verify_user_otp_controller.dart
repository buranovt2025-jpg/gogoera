import 'dart:developer';

import 'package:era_shop/Controller/GetxController/login/user_login_controller.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ApiModel/login/user_sand_otp_model.dart';
import '../../../ApiService/login/verify_user_otp_service.dart';
import '../../../utiles/show_toast.dart';
import 'api_enter_otp_controller.dart';

class UserVerifyOtpController extends GetxController {
  UserSandOtpModel? userSandOtp;
  RxBool getOtpLoading = false.obs;
  RxBool verifyOtpLoading = false.obs;

  final TextEditingController verifyOtpWhenLogin = TextEditingController();
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());

  getOtp({
    required String email,
  }) async {
    try {
      verifyOtpWhenLogin.clear();
      getOtpLoading(true);
      var data = await UserVerifyOtpService().sandOtp(email: email);
      userSandOtp = data;
    } finally {
      getOtpLoading(false);
    }
  }

  void verifyOtp({
    required String email,
    required String otp,
    required String pageIs,
  }) async {
    UserLoginController userLoginController = Get.put(UserLoginController());
    try {
      verifyOtpLoading(true);
      if (verifyOtpWhenLogin.text.isEmpty) {
        displayToast(message: "All fields are required \nto be filled");
      } else {
        await verifyOtpController.getVerifyOtpData(
          email: email,
          otp: otp,
        );
        if (verifyOtpController.verifyOtp!.status == true) {
          log("Page is :: $pageIs");
          pageIs == "SignUp" ? await userLoginController.userSignUp() : await userLoginController.signInLogin();
        } else {
          displayToast(message: St.invalidOTP.tr);
        }
      }
    } finally {
      verifyOtpLoading(false);
    }
  }
}
