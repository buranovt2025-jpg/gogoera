import 'dart:developer';

import 'package:era_shop/Controller/GetxController/seller/seller_common_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_button.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/dont_account.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_back_button.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class SellerEnterOtp extends StatelessWidget {
  SellerEnterOtp({super.key});

  SellerCommonController sellerController = Get.put(SellerCommonController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String otpCode = "";
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: Get.width / 20, right: Get.width / 20),
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
                  child: Obx(
                    () => RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: St.otpSubtitlePhone.tr,
                          style: GoogleFonts.plusJakartaSans(color: MyColors.darkGrey),
                          children: <TextSpan>[
                            TextSpan(
                              text: sellerController.mobileNumberController.text,
                              style: GoogleFonts.plusJakartaSans(
                                  color: isDark.value ? MyColors.white : MyColors.black, fontWeight: FontWeight.w600),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 45),
                child: Pinput(
                  onChanged: (value) {
                    otpCode = value;
                  },
                  // separator: const SizedBox(
                  //   width: 10,
                  // ),
                  length: 6,
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
              CommonSignInButton(
                  onTaped: () async {
                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: SellerCommonController.otpVerificationId,
                        smsCode: otpCode,
                      );
                      await auth.signInWithCredential(credential);
                      Get.toNamed("/SellerAddressDetails");
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        if (e.code == 'invalid-verification-code') {
                          displayToast(message: St.invalidOTP.tr);
                        } else {
                          log('Firebase Auth Exception: ${e.code}');
                        }
                      } else {
                        log('Unexpected error: $e');
                      }
                    }
                  },
                  text: St.continueText.tr),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: DoNotAccount(
                    onTaped: () async {
                      displayToast(message: St.pleaseWaitToast.tr);
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "+${sellerController.countryCode} ${sellerController.mobileNumberController.text}",
                        verificationCompleted: (PhoneAuthCredential credential) {
                          Get.toNamed("/SellerAddressDetails");
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          log("verification Failed Error :: $e");
                          displayToast(message: "Mobile Verification Failed");
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          displayToast(message: St.otpSendSuccessfully.tr);
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    tapText: St.resendCodeText.tr,
                    text: St.donReceiveCode.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
