import 'dart:developer';

import 'package:era_shop/localization/locale_constant.dart';
import 'package:era_shop/localization/localizations_delegate.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/theme_service.dart';
 import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  LanguageController languageController = Get.put(LanguageController());
  int selectedLanguageIndex = -1;

  List<String> suggestedLanguages = ['English (UK)', 'English', 'Bahasa Indonesia'];
  List<String> otherLanguages = ['Chineses', 'Croatian', 'Czech', 'Danish', 'Filipino', 'Finland'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: GeneralTitle(title: St.language.tr),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: PrimaryRoundButton(
                  //     onTaped: () {
                  //       Get.back();
                  //     },
                  //     icon: Icons.done,iconColor: MyColors.primaryPink,
                  //   ),
                  // ).paddingOnly(right: 15,top: 10),
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
          child: Column(
            children: [
              /*
               const SizedBox(
                height: 15,
              ),Container(
                height: 218,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: isDark.value ? MyColors.lightBlack : Colors.transparent,
                  border:
                      Border.all(color: isDark.value ? Colors.grey.shade600.withOpacity(0.30) : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(
                            "Suggested Languages",
                            style: TextStyle(
                                color: isDark.value ? MyColors.white : Colors.grey.shade600,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: suggestedLanguages.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                buildLanguageTile(suggestedLanguages[index], index, MyColors.primaryPink),
                                Divider(
                                  height: 3,
                                  color: MyColors.darkGrey.withOpacity(0.40),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Container(
                    height: 305,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: isDark.value ? MyColors.lightBlack : Colors.transparent,
                      border: Border.all(
                          color: isDark.value ? Colors.grey.shade600.withOpacity(0.30) : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 20, bottom: 5),
                            //   child: Text(
                            //     "Other Languages",
                            //     style: TextStyle(
                            //         color: isDark.value ? MyColors.white : Colors.grey.shade600,
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.w500),
                            //   ),
                            // ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: languages.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    buildLanguageTile(languages[index].language, index, languages[index].languageCode),
                                    Divider(
                                      height: 3,
                                      color: MyColors.darkGrey.withOpacity(0.40),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildLanguageTile(String language, int index, String languageCode) {
    // bool isSelected = index == selectedLanguageIndex;
    return GetBuilder<LanguageController>(
      id: "idLanguage",
      builder: (logic) {
        return ListTile(
          onTap: () {
            print("***************** => ${languages[index].languageCode}");
            logic.onLanguageSave(languages[index], index);
          },

          title: Text(
            language,
            style: GoogleFonts.plusJakartaSans(
                color: isDark.value ? MyColors.white : MyColors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          trailing: logic.checkedValue == index
              ? Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.primaryPink,
                  ),
                  child: Icon(Icons.done_outlined,
                      color: isDark.value ? MyColors.blackBackground : const Color(0xffffffff), size: 15),
                )
              : null,
          // tileColor: isSelected ? color.withOpacity(0.3) : null,
        );
      },
    );
  }
}

class LanguageController extends GetxController {
  int checkedValue = getStorage.read<int>('checkedValue') ?? 3;

  LanguageModel? languagesChosenValue;

  String? prefLanguageCode;
  String? prefCountryCode;

  @override
  void onInit() {
    getLanguageData();
    log("prefLanguageCode:::$prefLanguageCode");
    log("prefCountryCode:::$prefCountryCode");
    super.onInit();
  }

  getLanguageData() {
    prefLanguageCode = getStorage.read(LocalizationConstant.selectedLanguage) ?? LocalizationConstant.languageEn;
    prefCountryCode = getStorage.read(LocalizationConstant.selectedCountryCode) ?? LocalizationConstant.countryCodeEn;
    log("prefLanguageCode:::$prefLanguageCode");
    log("prefCountryCode:::$prefCountryCode");
    languagesChosenValue = languages
        .where((element) => (element.languageCode == prefLanguageCode && element.countryCode == prefCountryCode))
        .toList()[0];
    update(["idLanguage"]);
  }

  // onLanguageSave(String? languageCode) {
  //   languagesChosenValue!.languageCode ==
  //       getStorage.write(LocalizationConstant.selectedLanguage, languagesChosenValue!.languageCode);
  //   getStorage.write(LocalizationConstant.selectedCountryCode, languagesChosenValue!.countryCode);
  //   Get.updateLocale(Locale(languagesChosenValue!.languageCode, languagesChosenValue!.countryCode));
  //   Future.delayed(
  //     Duration(milliseconds: 1000),
  //     () {
  //       Get.back();
  //     },
  //   );
  //   Get.back();`
  // }
  void onLanguageSave(LanguageModel value, int index) {
    languagesChosenValue = value;

    checkedValue = index;

    getStorage.write('checkedValue', checkedValue);

    getStorage.write(LocalizationConstant.selectedLanguage, languagesChosenValue!.languageCode);
    getStorage.write(LocalizationConstant.selectedCountryCode, languagesChosenValue!.countryCode);

    Future.delayed(
      Duration(milliseconds: 1000),
      () {
        Get.updateLocale(Locale(languagesChosenValue!.languageCode, languagesChosenValue!.countryCode));
        Get.back();
      },
    );
  }

  onChangeLanguage(LanguageModel value, int index) {
    languagesChosenValue = value;

    checkedValue = index;

    getStorage.write('checkedValue', checkedValue);

    update(["idLanguage"]);
  }
}
