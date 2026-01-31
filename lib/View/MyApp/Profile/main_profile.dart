import 'dart:developer';
import 'dart:io';

import 'package:era_shop/Controller/ApiControllers/seller/api_seller_login_controller.dart';
import 'package:era_shop/Controller/GetxController/login/google_login_controller.dart';
import 'package:era_shop/Controller/GetxController/user/delete_user_account_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/profile_options.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/Theme/theme_service.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({Key? key}) : super(key: key);

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool changeMode = false;
  GoogleLoginController googleLoginController = Get.put(GoogleLoginController());
  SellerLoginController sellerLoginController = Get.put(SellerLoginController());
  DeleteUserAccountController deleteUserAccountController = Get.put(DeleteUserAccountController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (isDark.value == true) {
      changeMode = true;
    } else {
      changeMode = false;
    }
  }

  ThemeService themeService = ThemeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              child: imageXFile == null
                                  ? CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(editImage),
                                    )
                                  : CircleAvatar(
                                      radius: 28,
                                      backgroundImage: FileImage(File(imageXFile!.path)),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width / 1.6,
                                    child: GeneralTitle(title: "${editFirstName.capitalizeFirst} $editLastName"),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    uniqueID,
                                    style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xff78828A), fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: SizedBox(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/EditProfile");
                                },
                                child: Obx(
                                  () => Image(
                                    image: AssetImage(AppImage.profileEdit),
                                    color: isDark.value ? MyColors.white : MyColors.black,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height / 30,
                  ),
                  Text(
                    St.personalInfo.tr,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileOptions(
                      image: AssetImage(AppImage.myOrder),
                      text: St.myOrder.tr,
                      onTap: () {
                        Get.toNamed("/MyOrder");
                      }),
                  ProfileOptions(
                      image: AssetImage(AppImage.myAddress),
                      text: St.myAddress.tr,
                      onTap: () {
                        Get.toNamed("/UserAddress");
                      }),
                  ProfileOptions(
                      image: const AssetImage("assets/bottombar_image/unselected/Heart.png"),
                      text: St.myFavorite.tr,
                      onTap: () {
                        Get.toNamed("/MyFavorite");
                      }),
                  ProfileOptions(
                      image: AssetImage(AppImage.messageBlack),
                      text: "Сообщения",
                      onTap: () {
                        Get.toNamed("/Message");
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    St.seller.tr,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  becomeSeller == true
                      ? GestureDetector(
                          onTap: () {
                            Get.toNamed("/SellerProfile");
                          },
                          child: Container(
                            height: 55,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Obx(
                                  () => Image(
                                    color: isDark.value ? MyColors.white : MyColors.black,
                                    image: const AssetImage("assets/profile_icons/become seller.png"),
                                    height: 22,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        editBusinessName,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15.7,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Image(
                                            image: AssetImage("assets/profile_icons/seller done.png"), height: 21),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: MyColors.mediumGrey,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : ProfileOptions(
                          image: const AssetImage("assets/profile_icons/become seller.png"),
                          text: St.becomeSeller.tr,
                          onTap: () {
                            if (isSellerRequestSand == true) {
                              Get.toNamed("/SellerAccountVerification");
                            } else {
                              Get.toNamed("/SellerLogin");
                            }
                          }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    St.security.tr,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileOptions(
                      image: AssetImage(AppImage.changePassword),
                      text: St.changePassword.tr,
                      onTap: () {
                        Get.toNamed("/ChangePassword");
                      }),
                  ProfileOptions(
                      image: AssetImage(AppImage.forgotPassword),
                      text: St.forgotPassword.tr,
                      onTap: () {
                        Get.toNamed("/UserForgotPassword");
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    St.general.tr,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileOptions(
                      image: AssetImage(AppImage.language),
                      text: St.language.tr,
                      onTap: () {
                        Get.toNamed("/Language");
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    St.about.tr,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileOptions(
                      image: AssetImage(AppImage.policies),
                      text: St.legalAndPolicies.tr,
                      onTap: () {
                        Get.toNamed("/LegalAndPolicies");
                      }),
                  ProfileOptions(
                      image: AssetImage(AppImage.helpSupport),
                      text: St.helpAndSupport.tr,
                      onTap: () {
                        Get.toNamed("/HelpAndSupport");
                      }),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: 55,
                      // color: Colors.purple.shade100,
                      child: Row(
                        children: [
                          Obx(
                            () => Image(
                              color: isDark.value ? MyColors.white : MyColors.black,
                              image: AssetImage(AppImage.darkMode),
                              height: 22,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              St.darkMode.tr,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Transform.scale(
                            scale: 0.8,
                            transformHitTests: false,
                            child: CupertinoSwitch(
                              activeColor: MyColors.primaryPink,
                              value: changeMode,
                              onChanged: (value) {
                                setState(() {});
                                if (isDark.value) {
                                  isDark.value = false;
                                } else {
                                  isDark.value = true;
                                }
                                changeMode = value;
                                themeService.switchTheme();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: PrimaryWhiteButton(
                        onTaped: () {
                          Get.defaultDialog(
                            backgroundColor: isDark.value ? MyColors.blackBackground : MyColors.white,
                            title: St.dialogBoxLogoutTitle.tr,
                            titlePadding: const EdgeInsets.only(top: 45),
                            titleStyle: GoogleFonts.plusJakartaSans(
                                color: isDark.value ? MyColors.white : MyColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            content: Column(
                              children: [
                                SizedBox(
                                  height: Get.height / 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: PrimaryPinkButton(
                                      onTaped: () {
                                        Get.back();
                                      },
                                      text: St.cancelSmallText.tr),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      googleLoginController.googleUser == null ? googleLoginController.logOut() : null;

                                      Get.offAllNamed("/SignIn");
                                      getStorage.erase();
                                      isDemoSeller = false;
                                      isSellerRequestSand = false;
                                      becomeSeller = false;
                                    },
                                    child: Text(
                                      St.logout.tr,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600, fontSize: 14, color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        text: St.logout.tr),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: PrimaryWhiteButton(
                        onTaped: () {
                          Get.defaultDialog(
                            backgroundColor: isDark.value ? MyColors.blackBackground : MyColors.white,
                            title: St.deleteAccount.tr,
                            titlePadding: const EdgeInsets.only(top: 45),
                            titleStyle: GoogleFonts.plusJakartaSans(
                                color: isDark.value ? MyColors.white : MyColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            content: Column(
                              children: [
                                SizedBox(
                                  height: Get.height / 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: PrimaryPinkButton(
                                      onTaped: () {
                                        Get.back();
                                      },
                                      text: St.cancelSmallText.tr),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                                  child: GestureDetector(
                                    onTap: isDemoSeller == true
                                        ? () => displayToast(message: St.thisIsDemoApp.tr)
                                        : () async {
                                            log("UserId ::: $userId");
                                            await deleteUserAccountController.deleteAccount(userId);
                                          },
                                    child: Text(
                                      St.removeAccount.tr,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600, fontSize: 14, color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        text: St.removeAccount.tr),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
