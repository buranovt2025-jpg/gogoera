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

class SellerAddress extends StatelessWidget {
  const SellerAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(const SellerProfile(), transition: Transition.leftToRight);
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: PrimaryRoundButton(
                        onTaped: () {
                          Get.off(const SellerProfile(), transition: Transition.leftToRight);
                          // Get.back();
                        },
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.myAddress.tr),
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
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Container(
                  // height: 133,
                  width: double.maxFinite,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallTitle(title: "$editFirstName $editLastName"),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Obx(
                          () => Text(
                            editPhoneNumber,
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: isDark.value ? MyColors.white : Colors.grey.shade600),
                          ),
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "$editSellerAddress, $editLandmark,\n$editCity, $editPinCode.",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: isDark.value ? MyColors.white : Colors.grey.shade600),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isDemoSeller == true
                              ? displayToast(message: St.thisIsDemoApp.tr)
                              : Get.offNamed("/SellerEditAddress");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 5),
                          child: Container(
                            height: 32,
                            width: Get.width / 2.7,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors.primaryPink,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                St.changeAddress.tr,
                                style: GoogleFonts.plusJakartaSans(
                                    color: MyColors.primaryPink, fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
