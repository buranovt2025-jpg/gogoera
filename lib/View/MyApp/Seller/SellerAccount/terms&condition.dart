import 'package:era_shop/Controller/GetxController/seller/seller_common_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  SellerCommonController sellerController = Get.put(SellerCommonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: PrimaryPinkButton(
            onTaped: () {
              if (sellerController.termsList.every((term) => term.isSelectedTerms.value)) {
                sellerController.sellerTAndC();
              } else {
                displayToast(message: St.termsAndConditionsNotAccepted.tr);
              }
            },
            text: St.continueText.tr),
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
              () => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      St.termsAndCondition.tr,
                      style: isDark.value ? SignInTitleStyle.whiteTitle : SignInTitleStyle.blackTitle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        St.agreeToSelling.tr,
                        style: GoogleFonts.plusJakartaSans(color: MyColors.darkGrey),
                      ),
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 20, left: 6),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: sellerController.termsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 17),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {});
                              sellerController.termsList[index].isSelectedTerms.isFalse
                                  ? sellerController.termsList[index].isSelectedTerms(true)
                                  : sellerController.termsList[index].isSelectedTerms(false);
                            },
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Obx(
                                          () => sellerController.termsList[index].isSelectedTerms.value
                                              ? Container(
                                                  height: 24,
                                                  width: 24,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: MyColors.primaryPink,
                                                  ),
                                                  child: Icon(Icons.done_outlined,
                                                      color: isDark.value
                                                          ? MyColors.blackBackground
                                                          : const Color(0xffffffff),
                                                      size: 15),
                                                )
                                              : Container(
                                                  height: 24,
                                                  width: 24,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Colors.grey.shade400)),
                                                ),
                                        ),
                                      ),
                                      Text(
                                        sellerController.termsList[index].title,
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w700, fontSize: 16.7),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 34, top: 6, bottom: 9),
                                    child: Text(sellerController.termsList[index].description,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: MyColors.darkGrey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            height: 1.6)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
