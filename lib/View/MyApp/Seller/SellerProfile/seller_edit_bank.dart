// ignore_for_file: must_be_immutable

import 'package:era_shop/Controller/GetxController/seller/seller_edit_profile_controller.dart';
import 'package:era_shop/View/MyApp/Seller/SellerProfile/seller_bank_account.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerEditBank extends StatelessWidget {
  SellerEditBank({super.key});
  SellerEditProfileController sellerEditProfileController = Get.put(SellerEditProfileController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(const SellerBankAccount(), transition: Transition.leftToRight);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: PrimaryPinkButton(
              onTaped: () async {
                await sellerEditProfileController.sellerEditProfile();
                Get.off(const SellerBankAccount(), transition: Transition.leftToRight);
                // Get.back();
              },
              text: St.saveChanges.tr),
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
                          Get.off(const SellerBankAccount(), transition: Transition.leftToRight);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        St.bankNameText.tr ,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: DropdownButtonFormField<String>(
                    value: editBankName,
                    onChanged: (value) {
                      sellerEditProfileController.editBankNameController.text = value!;
                    },
                    dropdownColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                    style: TextStyle(color: isDark.value ? MyColors.dullWhite : MyColors.black, fontSize: 16),
                    decoration: InputDecoration(
                        hintText: St.stateTFHintText.tr,
                        filled: true,
                        fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                        hintStyle: GoogleFonts.plusJakartaSans(color: Colors.grey.shade400, fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                            borderRadius: BorderRadius.circular(24)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.primaryPink),
                            borderRadius: BorderRadius.circular(26))),
                    icon: const Icon(Icons.expand_more_outlined),
                    items: <String>[
                      'Axis',
                      "HDFC",
                      "SBI",
                      'Kotak',
                      'IndusInd',
                      "ICICI",
                      "IDBI",
                    ].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Container(
                          height: 50,
                          color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                          child: Center(
                            child: Text(
                              value,
                              style: GoogleFonts.plusJakartaSans(
                                  color: isDark.value ? MyColors.white : MyColors.black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                PrimaryTextField(
                  titleText: St.accountNumTitle.tr,
                  hintText: St.enterAccountNum.tr,
                  controllerType: "EditBankAccNum",
                ),
                const SizedBox(height: 15),
                PrimaryTextField(
                  titleText: St.ifscText.tr,
                  hintText: St.ifscHintText.tr,
                  controllerType: "EditIFSC",
                ),
                const SizedBox(height: 15),
                PrimaryTextField(
                  titleText: St.branchText.tr,
                  hintText: St.enterBranch.tr,
                  controllerType: "EditBranch",
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
