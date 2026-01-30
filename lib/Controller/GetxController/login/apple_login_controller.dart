import 'dart:developer';

import 'package:era_shop/Controller/GetxController/login/login_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_button.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  loginWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
      );
      var auth = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final user = auth.user;
      if (user != null) {
        ///=====CALL API======///
        displayToast(message: St.pleaseWaitToast.tr);
        await loginController.getLoginData(
          email: user.email ?? '',
          password: "",
          loginType: 1,
          fcmToken: fcmToken,
          identity: identify,
          firstName: '',
          lastName: '',
        );
        if (loginController.userLogin!.status == true) {
          Get.defaultDialog(
            barrierDismissible: false,
            backgroundColor: isDark.value ? MyColors.blackBackground : MyColors.white,
            title: "",
            content: Column(
              children: [
                Container(
                  height: 96,
                  width: 96,
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: Icon(
                    Icons.done,
                    color: isDark.value ? MyColors.blackBackground : MyColors.white,
                    size: 60,
                  ),
                ),
                SizedBox(
                  height: Get.height / 30,
                ),
                Text(
                  "You have logging\n"
                  "successfully",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                      color: isDark.value ? MyColors.white : MyColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the\n"
                    " printing and typesetting industry.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: Get.height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CommonSignInButton(
                      onTaped: () {
                        Get.back();
                        Get.offAllNamed("/BottomTabBar");
                      },
                      text: "Continue"),
                )
              ],
            ),
          );
        } else {
          displayToast(message: St.somethingWentWrong.tr);
        }
      } else {
        log("Google Login Current user is Null");
      }
    } catch (e) {
      displayToast(message: St.somethingWentWrong.tr);
      log(" $e");
    }
  }
}
