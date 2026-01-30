import 'package:era_shop/View/OnboardingScreens/on_boarding.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageManage extends StatefulWidget {
  const PageManage({Key? key}) : super(key: key);

  @override
  State<PageManage> createState() => _PageManageState();
}

class _PageManageState extends State<PageManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: onBoardingImage[index],
                );
              },
            ),
            // Кнопка «Пропустить» — всегда видна вверху справа
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 16),
                  child: TextButton(
                    onPressed: () => Get.offAllNamed("/SignIn"),
                    child: Text(
                      "Пропустить",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          color: MyColors.primaryPink,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                color: Colors.transparent,
                child: Center(
                  child: SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        dotColor: MyColors.lightGrey,
                        activeDotColor: MyColors.primaryPink),
                    controller: pageController,
                    count: 3,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
