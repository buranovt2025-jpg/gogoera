import 'dart:developer';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_button.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_controller.dart';

class GoogleLoginController extends GetxController {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  LoginController loginController = Get.put(LoginController());

  // ignore: prefer_typing_uninitialized_variables
  var googleUser;
  RxBool isLoading = false.obs;

  Future googleLogin() async {
    try {
      isLoading(true);
      googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (FirebaseAuth.instance.currentUser != null) {
        ///=====CALL API======///
        await loginController.getLoginData(
          image: user.photoUrl,
          email: user.email.toString(),
          password: "",
          loginType: 1,
          fcmToken: fcmToken,
          identity: identify,
          firstName: user.displayName.toString(),
          lastName: 'era',
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
                // Padding(
                //   padding: const EdgeInsets.only(top: 15),
                //   child: Text(
                //     "Lorem Ipsum is simply dummy text of the\n"
                //     " printing and typesetting industry.",
                //     textAlign: TextAlign.center,
                //     style: GoogleFonts.plusJakartaSans(
                //         color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w500),
                //   ),
                // ),
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
    } on FirebaseAuthException catch (e) {
      log(e.code);
    } finally {
      isLoading(false);
    }
  }

  Future logOut() async {
    log("Google log Out");
    try {
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
    }
  }
}
