import 'package:era_shop/View/MyApp/Seller/seller_profile.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerBankAccount extends StatelessWidget {
  const SellerBankAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(const SellerProfile(), transition: Transition.leftToRight);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: PrimaryPinkButton(
              onTaped: () {
                isDemoSeller == true
                    ? displayToast(message: St.thisIsDemoApp.tr)
                    : Get.offNamed("/SellerEditBank");
              },
              text: St.changeBankDetails.tr),
        ),
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
                          Get.off(const SellerProfile(), transition: Transition.leftToRight);
                        },
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                      Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.bankAccount.tr),
                      ),
                    ),
                  ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  editBankName,
                  style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  "${St.accountNumTitle.tr} :",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  editAccNumber,
                  style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  "${St.iFSCCode.tr} :",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  editIfsc,
                  style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  "${St.branchName.tr} :",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  editBranch,
                  style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
