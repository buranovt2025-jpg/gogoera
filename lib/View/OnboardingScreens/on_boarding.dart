import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final pageController = PageController();

List onBoardingImage = [
  onBoardingFst(),
  onBoardingSnd(),
  onBoardingTrd(),
];

onBoardingFst() {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImage.entryFst), fit: BoxFit.cover)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlurryContainer(
          blur: 8,
          // height: 220,
          width: Get.width / 1.1,
          elevation: 0,
          color: Colors.white.withOpacity(0.75),
          padding: const EdgeInsets.all(8),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  St.onBoardingFstTitle.tr,
                  style: GoogleFonts.plusJakartaSans(
                      color: MyColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SizedBox(
                  height: 80,
                  width: Get.width / 1.4,
                  child: Text(
                    St.onBoardingFstSubtitle.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        color: MyColors.darkGrey,
                        fontSize: 15,
                        height: 1.5),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.linear);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 55,
                    width: 115,
                    decoration: BoxDecoration(
                      color: MyColors.primaryPink,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        St.nextText.tr,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            color: MyColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ),
  );
}

onBoardingSnd() {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImage.entrySecond), fit: BoxFit.cover)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlurryContainer(
          blur: 8,
          width: Get.width / 1.1,
          elevation: 0,
          color: Colors.white.withOpacity(0.75),
          padding: const EdgeInsets.all(8),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  St.onBoardingSndTitle.tr,
                  style: GoogleFonts.plusJakartaSans(
                      color: MyColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SizedBox(
                  height: 80,
                  width: Get.width / 1.4,
                  child: Text(
                    St.onBoardingSndSubtitle.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        color: MyColors.darkGrey,
                        fontSize: 15,
                        height: 1.5),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.linear);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 55,
                    width: 115,
                    decoration: BoxDecoration(
                      color: MyColors.primaryPink,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        St.nextText.tr,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            color: MyColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ),
  );
}

onBoardingTrd() {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImage.entryThird), fit: BoxFit.cover)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlurryContainer(
          blur: 8,
          width: Get.width / 1.1,
          elevation: 0,
          color: Colors.white.withOpacity(0.75),
          padding: const EdgeInsets.all(8),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  St.onBoardingTrdTitle.tr,
                  style: GoogleFonts.plusJakartaSans(
                      color: MyColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SizedBox(
                  height: 80,
                  width: Get.width / 1.4,
                  child: Text(
                    St.onBoardingTrdSubtitle.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        color: MyColors.darkGrey,
                        fontSize: 15,
                        height: 1.5),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed("/SignIn");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 55,
                    width: 115,
                    decoration: BoxDecoration(
                      color: MyColors.primaryPink,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        St.nextText.tr,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            color: MyColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ),
  );
}
