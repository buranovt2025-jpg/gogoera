import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/View/MyApp/AppPages/bottom_tab_bar.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/profile_options.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class SellerProfile extends StatefulWidget {
  const SellerProfile({Key? key}) : super(key: key);

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /* isDemoSeller == true
            ? Get.offAll(transition: Transition.leftToRight, const SignIn())
            :*/
        Get.offAll(
            transition: Transition.leftToRight,
            BottomTabBar(
              index: 4,
            ));
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              SizedBox(
                width: Get.width,
                height: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: PrimaryRoundButton(
                            onTaped: () {
                              /*isDemoSeller == true
                                  ? Get.offAll(transition: Transition.leftToRight, const SignIn())
                                  :*/
                              Get.offAll(
                                  transition: Transition.leftToRight,
                                  BottomTabBar(
                                    index: 4,
                                  ));
                              // Get.off(const MainProfile(),
                              //     transition: Transition.leftToRight);
                            },
                            icon: Icons.arrow_back_rounded),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: GeneralTitle(title: St.sellerAccount.tr),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed("/Notifications");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Obx(
                              () => Image(
                                image: isDark.value
                                    ? AssetImage(AppImage.notificationWhite)
                                    : AssetImage(AppImage.notificationBlack),
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: sellerImageXFile == null
                        ? FutureBuilder(
                            future: precacheImage(CachedNetworkImageProvider(sellerEditImage), context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 42,
                                  backgroundImage: CachedNetworkImageProvider(sellerEditImage),
                                );
                              } else {
                                return CircleAvatar(
                                    backgroundColor: MyColors.lightGrey,
                                    radius: 42,
                                    child: const Center(
                                      child: CupertinoActivityIndicator(),
                                    ));
                              }
                            },
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 42,
                            backgroundImage: FileImage(
                              File(sellerImageXFile!.path),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SmallTitle(title: editBusinessName),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      editBusinessTag,
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: MyColors.darkGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 47,
                        width: Get.width / 2.5,
                        decoration:
                            BoxDecoration(color: MyColors.primaryPink, borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/seller_user_followers.png",
                              height: 22,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              sellerFollower,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 17, fontWeight: FontWeight.w500, color: MyColors.white),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isDemoSeller == true
                              ? displayToast(message: St.thisIsDemoApp.tr)
                              : Get.toNamed("/SellerEditProfile");
                        },
                        child: Container(
                          height: 47,
                          width: Get.width / 2.5,
                          decoration:
                              BoxDecoration(color: MyColors.primaryPink, borderRadius: BorderRadius.circular(100)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/Edit Square.png",
                                height: 26,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                St.editText.tr,
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 17, fontWeight: FontWeight.w500, color: MyColors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Row(
                    children: [
                      Text(
                        St.personalInfo.tr,
                        style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileOptions(
                      image: const AssetImage("assets/icons/catalog.png"),
                      text: St.catalog.tr,
                      onTap: () {
                        Get.toNamed("/SellerCatalogScreen");
                      }),
                  ProfileOptions(
                      image: AssetImage(AppImage.myOrder),
                      text: St.myOrder.tr,
                      onTap: () {
                        Get.toNamed("/MyOrders");
                      }),
                  ProfileOptions(
                      image: AssetImage(AppImage.paymentMethod),
                      text: St.myWallet.tr,
                      onTap: () {
                        Get.toNamed("/MyWallet");
                      }),
                  ProfileOptions(
                      image: const AssetImage("assets/icons/live_strimming.png"),
                      text: St.liveStemming.tr,
                      onTap: () {
                        Get.toNamed("/LiveStreaming");
                      }),
                  ProfileOptions(
                      image: const AssetImage("assets/bottombar_image/unselected/ReelsU.png"),
                      text: "Upload Shorts",
                      onTap: () {
                        Get.toNamed("/UploadShort");
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        St.general.tr,
                        style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileOptions(
                      image: AssetImage(AppImage.myAddress),
                      text: St.myAddress.tr,
                      onTap: () {
                        Get.offNamed("/SellerAddress");
                      }),
                  ProfileOptions(
                      image: const AssetImage("assets/icons/bank.png"),
                      text: St.bankAccount.tr,
                      onTap: () {
                        Get.offNamed("/SellerBankAccount");
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        St.security.tr,
                        style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileOptions(
                      image: AssetImage(AppImage.changePassword),
                      text: St.changePassword.tr,
                      onTap: () => Get.toNamed("/SellerChangePassword")),
                  ProfileOptions(
                      image: AssetImage(AppImage.forgotPassword),
                      text: St.forgotPassword.tr,
                      onTap: () => Get.toNamed("/SellerForgotPassword")),
                  const SizedBox(
                    height: 20,
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
