// ignore_for_file: must_be_immutable

import 'package:era_shop/Controller/GetxController/user/UserPasswordManage/user_password_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/app_circular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utiles/globle_veriables.dart';
import '../../../../utiles/show_toast.dart';

class ChangePassword extends StatelessWidget {
  UserPasswordController userPasswordController = Get.put(UserPasswordController());

  ChangePassword({super.key});

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
                          child: GeneralTitle(title: St.changePassword.tr),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            child: PrimaryPinkButton(
              onTaped: isDemoSeller == true
                  ? () => displayToast(message: St.thisIsDemoApp.tr)
                  : () => userPasswordController.changePasswordByUser(),
              text: St.submit.tr,
            ),
          ),
          body: SafeArea(
              child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: SizedBox(
                        height: 60,
                        child: Text(
                          St.profileCPSubtitle.tr,
                          style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                      ChangePasswordField(
                      controllerType: "oldPassword",
                      titleText: St.oldPassword.tr,
                      hintText: St.oldPassword.tr,
                    ).paddingOnly(bottom: 15),
                    Divider(
                      color: MyColors.darkGrey.withOpacity(0.30),
                      thickness: 1,
                      height: 35,
                    ),
                    ChangePasswordField(
                      controllerType: "changePassword",
                      titleText: St.passwordTextFieldTitle.tr,
                      hintText: St.passwordTextFieldHintText.tr,
                    ),
                    ChangePasswordField(
                      controllerType: "changeConfirmPassword",
                      titleText: St.confirmPasswordTextFieldTitle.tr,
                      hintText: St.confirmPasswordTextFieldHintText.tr,
                    ).paddingOnly(bottom: 20, top: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: Icon(
                                Icons.done_rounded,
                                size: 20,
                                color: MyColors.primaryGreen,
                              ),
                            ),
                            Text(
                              St.passwordLengthNotice.tr,
                              style: GoogleFonts.plusJakartaSans(color: MyColors.primaryGreen, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: Icon(
                                Icons.done_rounded,
                                size: 20,
                                color: MyColors.primaryGreen,
                              ),
                            ),
                            Text(
                              "There must be a unique code like @!#",
                              style: GoogleFonts.plusJakartaSans(color: MyColors.primaryGreen, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
        Obx(() =>
            userPasswordController.changePasswordLoading.value ? ScreenCircular.blackScreenCircular() : const SizedBox.shrink())
      ],
    );
  }
}
