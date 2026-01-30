
import 'package:country_picker/country_picker.dart';
import 'package:era_shop/Controller/GetxController/seller/seller_common_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_titles.dart';

import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerLogin extends StatefulWidget {
  const SellerLogin({super.key});

  @override
  State<SellerLogin> createState() => _SellerLoginState();
}

class _SellerLoginState extends State<SellerLogin> {
  var imoges;
  SellerCommonController sellerController = Get.put(SellerCommonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: PrimaryPinkButton(
            onTaped: () {
              sellerController.sellerLogin();
            },
            text: St.nextText.tr),
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
                        Get.back();
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
              () => Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    St.completeSellerAccount.tr,
                    style: isDark.value ? SignInTitleStyle.whiteTitle : SignInTitleStyle.blackTitle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      St.completeSellerAccountSubTitle.tr,
                      style: GoogleFonts.plusJakartaSans(color: MyColors.darkGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  PrimaryTextField(
                    titleText: St.businessNameTFTitle.tr,
                    hintText: St.businessNameTFHintText.tr,
                    controllerType: "BusinessName",
                  ),
                  const SizedBox(height: 15),
                  PrimaryTextField(
                    titleText: St.businessTag.tr,
                    hintText: St.enterYourBusinessTag.tr,
                    controllerType: "BusinessTag",
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            St.mobileNumber.tr,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: GetBuilder<SellerCommonController>(
                              builder: (controller) => TextFormField(
                                keyboardType: TextInputType.number,
                                controller: sellerController.mobileNumberController,
                                style: TextStyle(color: isDark.value ? MyColors.dullWhite : MyColors.black),
                                decoration: InputDecoration(
                                    errorText: sellerController.mobileNumberValidate.value
                                        ? St.phoneNumberCanNotBeEmpty.tr
                                        : null,
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                          exclude: <String>['KN', 'MF'],
                                          favorite: <String>['SE'],
                                          //Optional. Shows phone code before the country name.
                                          showPhoneCode: true,
                                          onSelect: (Country country) {
                                            setState(() {
                                              imoges = country.flagEmoji;
                                              sellerController.countryCode = country.phoneCode;
                                            });
                                          },
                                          countryListTheme: CountryListThemeData(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(40.0),
                                              topRight: Radius.circular(40.0),
                                            ),
                                            inputDecoration: InputDecoration(
                                              hintText: St.searchText.tr,
                                              prefixIcon: const Icon(Icons.search),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                                                ),
                                              ),
                                            ),
                                            // Optional. Styles the text in the search field
                                            searchTextStyle: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18,
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height: 58,
                                        width: 75,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            imoges == null
                                                ? const Text("🇮🇳", style: TextStyle(fontSize: 25))
                                                : Text(imoges, style: const TextStyle(fontSize: 25)),
                                            Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.grey.shade400,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                    hintText: St.mobileNumberTFHintText.tr,
                                    hintStyle:
                                        GoogleFonts.plusJakartaSans(color: Colors.grey.shade400, fontSize: 16),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: isDark.value
                                            ? BorderSide(color: Colors.grey.shade800)
                                            : BorderSide.none,
                                        borderRadius: BorderRadius.circular(26)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: MyColors.primaryPink),
                                        borderRadius: BorderRadius.circular(26))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  PrimaryTextField(
                    titleText: St.emailTextFieldTitle.tr,
                    hintText: St.emailTextFieldHintText.tr,
                    controllerType: "eMail",
                  ),
                  const SizedBox(height: 15),
                  PrimaryPasswordField(
                    titleText: St.passwordTextFieldTitle.tr,
                    hintText: St.passwordTextFieldHintText,
                    controllerType: "Password",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
