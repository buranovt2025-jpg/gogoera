
import 'dart:io';

import 'package:era_shop/Controller/GetxController/login/user_login_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_button.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_textfield.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/dont_account.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/other_button.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/theme_service.dart';
import 'package:era_shop/utiles/app_circular.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/ApiControllers/seller/api_seller_data_controller.dart';
import '../../Controller/GetxController/login/google_login_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  UserLoginController userLoginController = Get.put(UserLoginController());
  SellerDataController sellerDataController = Get.put(SellerDataController());
  GoogleLoginController googleLoginController = Get.put(GoogleLoginController());

  RxBool demoLoginLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: MyColors.primaryPink,
          body: SafeArea(
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 15,
                  ),
                  Text(
                    St.welcomeTitle.tr,
                    style: SignInTitleStyle.whiteTitle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      St.welcomeSubtitle.tr,
                      style: GoogleFonts.plusJakartaSans(color: MyColors.white),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Obx(
                        () => Container(
                          height: Get.height / (1.4) + 15,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    CommonSignInTextField(
                                      titleText: St.emailTextFieldTitle.tr,
                                      hintText: St.emailTextFieldHintText.tr,
                                      controllerType: "FirstSignInEmail",
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: CommonSignInButton(
                                          text: St.conWithEmail.tr,
                                          onTaped: () {
                                            userLoginController.firstSignInWhenEmpty();
                                          },
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 35),
                                      child: Buttons.orContinue(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Buttons.googleButton(onTap: () {
                                        googleLoginController.googleLogin();
                                      }),
                                    ),
                                    (kIsWeb ? false : Platform.isIOS)?
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Buttons.appleButton(),
                                    ):SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 30),
                                      child: DoNotAccount(
                                        onTaped: () {
                                          Get.toNamed("/SignUp");
                                        },
                                        tapText: St.signUpText.tr,
                                        text: St.donHaveAccount.tr,
                                      ),
                                    ),
                                     GestureDetector(
                                      onTap: () async {
                                        isDemoSeller = true;
                                        getStorage.write("isDemoSeller", isDemoSeller);
                                        demoLoginLoading(true);
                                        await userLoginController.signInLogin(
                                            email: "erashoptest@gmail.com", password: "12345678");
                                        demoLoginLoading(false);
                                        // await sellerDataController.getDemoSellerData();
                                      },
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15), color: MyColors.primaryPink),
                                        child: Center(
                                          child: Text(St.sellerDemoAccount.tr,
                                              style: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: MyColors.white,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() => sellerDataController.loadingForDemoSeller.value ||
                googleLoginController.isLoading.value ||
                demoLoginLoading.value
            ? ScreenCircular.blackScreenCircular()
            : const SizedBox.shrink())
      ],
    );
  }
}
