// ignore_for_file: use_key_in_widget_constructors


import 'package:chewie/chewie.dart';
import 'package:era_shop/View/MyApp/Seller/Reels/shorts_preview.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../Controller/GetxController/seller/manage_reels_controller.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/text_titles.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/textfields.dart';
import '../../../../utiles/Theme/my_colors.dart';
import '../../../../utiles/globle_veriables.dart';

class CreateShort extends StatelessWidget {
  ManageShortsController manageShortsController = Get.put(ManageShortsController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        manageShortsController.reelsXFiles = null;
        manageShortsController.selectProductName.clear();
        manageShortsController.selectedProductDescription.clear();
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
                          manageShortsController.reelsXFiles = null;
                          manageShortsController.selectProductName.clear();
                          manageShortsController.selectedProductDescription.clear();
                          Get.back();
                        },
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                      Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.createShorts.tr),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  GetBuilder<ManageShortsController>(
                    builder: (ManageShortsController manageShortsController) {
                      return manageShortsController.reelsXFiles == null
                          ? GestureDetector(
                              onTap: () {
                                manageShortsController.reelsPickFromGallery();
                              },
                              child: Container(
                                height: 400,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: MyColors.lightGrey)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/icons/add_image.png",
                                      height: 30.2,
                                      color: MyColors.mediumGrey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        St.selectVideoFromGallery.tr,
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12.4,
                                            color: MyColors.mediumGrey,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 400,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Chewie(
                                controller: ChewieController(
                                  videoPlayerController:
                                      VideoPlayerController.file(manageShortsController.reelVideo!),
                                  // aspectRatio: Get.width / 430,
                                  aspectRatio: manageShortsController.videoPlayerController!.value.aspectRatio,
                                  showControls: false,
                                  autoPlay: true,
                                  autoInitialize: true,
                                  looping: true,
                                ),
                              ),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryTextField(
                    titleText: St.businessNameTFTitle.tr,
                    hintText: editBusinessName,
                    controllerType: "ReelsBusinessName",
                  ),
                  const SizedBox(height: 14),
                  PrimaryTextField(
                    titleText:  St.selectProduct.tr,
                    hintText: St.tapToSelectProduct.tr,
                    controllerType: "ReelsSelectProduct",
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          St.description.tr,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => TextField(
                      controller: manageShortsController.selectedProductDescription,
                      maxLines: 15,
                      minLines: 7,
                      style: TextStyle(color: isDark.value ? MyColors.dullWhite : MyColors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                        enabledBorder: OutlineInputBorder(
                            borderSide: isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                            borderRadius: BorderRadius.circular(24)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.primaryPink),
                            borderRadius: BorderRadius.circular(26)),
                        hintText: St.addDescriptionAboutYourProduct.tr,
                        hintStyle:
                            GoogleFonts.plusJakartaSans(height: 1.6, color: MyColors.mediumGrey, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: PrimaryPinkButton(
                        onTaped:  () {
                                manageShortsController.reelsXFiles == null
                                    ? displayToast(message: St.selectAVideoToProceed.tr)
                                    : manageShortsController.selectProductName.text.isEmpty
                                        ? displayToast(message: St.selectAProductToProceed.tr)
                                        : manageShortsController.selectedProductDescription.text.isEmpty
                                            ? displayToast(message: St.selectADescriptionToProceed.tr)
                                            : Get.to(() =>   ShortsPreview(productDescription:manageShortsController.selectedProductDescription.text ,),
                                                transition: Transition.rightToLeft);
                              },
                        text: St.preview.tr),
                  ).paddingOnly(top: 10, bottom: 5)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
