import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_button.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/dont_account.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_back_button.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../../Controller/GetxController/user/UserPasswordManage/user_password_controller.dart';
import '../../../../utiles/app_circular.dart';

// ignore: must_be_immutable
class UserEnterOtp extends StatelessWidget {
  UserEnterOtp({super.key});
  UserPasswordController userPasswordController = Get.put(UserPasswordController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: Get.width / 20, right: Get.width / 20),
              child: SizedBox(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SignInBackButton(
                            onTaped: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height / 15,
                      ),
                      Obx(
                        () => Text(
                          St.enterOTP.tr,
                          style: isDark.value ? SignInTitleStyle.whiteTitle : SignInTitleStyle.blackTitle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: SizedBox(
                          width: Get.width / 1.3,
                          height: 40,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: St.otpSubtitleEmail.tr,
                                style: GoogleFonts.plusJakartaSans(color: MyColors.darkGrey),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: userPasswordController.enterEmail.text,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w600, color: MyColors.black),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 45),
                        child: GetBuilder<UserPasswordController>(
                          builder: (controller) => Pinput(
                            controller: userPasswordController.verifyOtpText,
                            // separator: const SizedBox(
                            //   width: 20,
                            // ),
                            keyboardType: TextInputType.number,
                            cursor: Container(
                              height: 23,
                              width: 2,
                              color: MyColors.primaryPink,
                            ),
                            submittedPinTheme: PinTheme(
                              height: 55,
                              width: 55,
                              textStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: MyColors.primaryPink,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: isDark.value ? MyColors.blackBackground : MyColors.white,
                              ),
                            ),
                            defaultPinTheme: PinTheme(
                              height: 55,
                              width: 55,
                              textStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: MyColors.primaryPink,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: isDark.value ? MyColors.blackBackground : MyColors.white,
                              ),
                            ),
                            followingPinTheme: PinTheme(
                              height: 55,
                              width: 55,
                              textStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: MyColors.primaryPink,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: isDark.value ? MyColors.blackBackground : MyColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CommonSignInButton(
                          onTaped: () {
                            userPasswordController.verifyOtp();
                          },
                          text: St.continueText.tr),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: DoNotAccount(
                            onTaped: () {
                              userPasswordController.resendOtpByUser();
                            },
                            tapText: St.resendCodeText.tr,
                            text: St.donReceiveCode.tr),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => userPasswordController.verifyOtpLoading.value || userPasswordController.resendOtpLoading.value
              ? ScreenCircular.blackScreenCircular()
              : const SizedBox(),
        ),
      ],
    );
  }
}
