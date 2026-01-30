import 'package:era_shop/Controller/GetxController/login/apple_login_controller.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttons {
  static orContinue() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 1,
            width: 65,
            color: isDark.value ? MyColors.white : MyColors.darkGrey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              St.orContinueWith.tr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark.value ? MyColors.white : MyColors.darkGrey,
              ),
            ),
          ),
          Container(
            height: 1,
            width: 65,
            color: isDark.value ? MyColors.white : MyColors.darkGrey,
          ),
        ],
      ),
    );
  }

  static googleButton({required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            border: Border.all(
              color: isDark.value ? MyColors.white : MyColors.black,
            ),
            color: isDark.value ? MyColors.blackBackground : MyColors.white,
            borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Image(
                  image: AssetImage(AppImage.googleIcon),
                  height: 24,
                ),
              ),
              Text(
                "Continue with Google",
                style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static appleButton() {
    AppleLoginController appleLoginController = Get.put(AppleLoginController());
    return GestureDetector(
      onTap: () async {
        await appleLoginController.loginWithApple();
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            border: Border.all(
              color: isDark.value ? MyColors.white : MyColors.black,
            ),
            color: isDark.value ? MyColors.blackBackground : MyColors.white,
            borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Image(
                  image: AssetImage(AppImage.appleIcon),
                  color: isDark.value ? MyColors.white : MyColors.black,
                  height: 24,
                ),
              ),
              Text(
                "Continue with Apple",
                style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
