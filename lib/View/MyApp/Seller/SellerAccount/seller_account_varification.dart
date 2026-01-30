import 'package:era_shop/View/MyApp/AppPages/bottom_tab_bar.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerAccountVerification extends StatefulWidget {
  const SellerAccountVerification({super.key});

  @override
  State<SellerAccountVerification> createState() => _AccountVerification();
}

class _AccountVerification extends State<SellerAccountVerification> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
            transition: Transition.leftToRight,
            BottomTabBar(
              index: 4,
            ));
        return false;
      },
      child: Scaffold(
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        //   child: PrimaryPinkButton(
        //       onTaped: () {
        //         // here navigate
        //       },
        //       text: Strings.continueText),
        // ),
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
                          Get.offAll(
                              transition: Transition.leftToRight,
                              BottomTabBar(
                                index: 4,
                              ));
                          // Get.back();
                        },
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.sellerAccount.tr),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
              child: Obx(
                () => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        St.accountVerification.tr,
                        style: isDark.value ? SignInTitleStyle.whiteTitle : SignInTitleStyle.blackTitle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Text(
                          St.verifyToSelling.tr,
                          style: GoogleFonts.plusJakartaSans(color: MyColors.darkGrey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: SizedBox(
                          child: Text(St.thankYouForCreatingAnAccount.tr,
                              style: GoogleFonts.plusJakartaSans(
                                  color: MyColors.darkGrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  height: 1.6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
