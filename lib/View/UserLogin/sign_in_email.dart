import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:era_shop/Controller/GetxController/login/user_login_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_button.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_passwordfield.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/common_sign_in_textfield.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/dont_account.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/other_button.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/GetxController/login/google_login_controller.dart';
import '../../Controller/GetxController/login/login_controller.dart';
import '../../utiles/app_circular.dart';

class SignInEmail extends StatefulWidget {
  const SignInEmail({Key? key}) : super(key: key);

  @override
  State<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  LoginController loginController = Get.put(LoginController());
  bool valueFirst = false;
  UserLoginController userLogin = Get.put(UserLoginController());
  GoogleLoginController googleLoginController = Get.put(GoogleLoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                SizedBox(
                  width: Get.width,
                  height: double.maxFinite,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: PrimaryRoundButton(
                          onTaped: () {
                            Get.back();
                          },
                          icon: Icons.arrow_back_rounded,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: GeneralTitle(title: St.signInText.tr),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  child: Obx(
                    () => Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Get.height / 30),
                              child: CommonSignInTextField(
                                titleText: St.emailTextFieldTitle.tr,
                                hintText: St.emailTextFieldHintText.tr,
                                controllerType: "SignInEmail",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: CommonSignInPasswordField(
                                titleText: St.passwordTextFieldTitle.tr,
                                hintText: St.passwordTextFieldHintText.tr,
                                controllerType: "SignInPassword",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Checkbox(
                                    side: BorderSide(color: MyColors.lightGrey, style: BorderStyle.solid),
                                    shape: const CircleBorder(),
                                    checkColor: MyColors.white,
                                    activeColor: MyColors.primaryPink,
                                    value: valueFirst,
                                    onChanged: (value) {
                                      setState(() {
                                        valueFirst = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    St.rememberMe.tr,
                                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/ForgotPassword");
                              },
                              child: Text(
                                St.forgotPassword.tr,
                                style: GoogleFonts.plusJakartaSans(
                                    color: MyColors.primaryPink, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CommonSignInButton(
                              onTaped: () {
                                userLogin.signInLogin();
                              },
                              text: St.signInText.tr),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Buttons.orContinue(),
                        ),
                        Buttons.googleButton(onTap: () => googleLoginController.googleLogin()),

                        (kIsWeb ? false : Platform.isIOS)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Buttons.appleButton(),
                          )
                        : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: DoNotAccount(
                            onTaped: () {
                              Get.toNamed("/SignUp");
                            },
                            tapText: St.signUpText.tr,
                            text: St.donHaveAccount.tr,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
        ),
        Obx(() => userLogin.signInOtpLoading.value || googleLoginController.isLoading.value
            ? ScreenCircular.blackScreenCircular()
            : const SizedBox())
      ],
    );
  }
}
