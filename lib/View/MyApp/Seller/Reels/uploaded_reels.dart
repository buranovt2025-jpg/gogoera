import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/View/MyApp/Seller/Reels/shorts_preview.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Controller/ApiControllers/seller/show_catalog_controller.dart';
import '../../../../Controller/GetxController/seller/manage_reels_controller.dart';
import '../../../../Controller/GetxController/seller/show_uploaded_reels_controller.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import '../../../../utiles/Theme/my_colors.dart';
import '../../../../utiles/globle_veriables.dart';
import '../../../../utiles/shimmers.dart';

class UploadedShort extends StatefulWidget {
  const UploadedShort({super.key});

  @override
  State<UploadedShort> createState() => _UploadedShortState();
}

class _UploadedShortState extends State<UploadedShort> {
  ShowCatalogController showCatalogController = Get.put(ShowCatalogController());
  ShowUploadedShortsController showUploadedShortsController = Get.put(ShowUploadedShortsController());
  ManageShortsController manageShortsController = Get.put(ManageShortsController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      _scrollListener();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showUploadedShortsController.getReels();
      showCatalogController.getCatalogData();
    });
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      log("ScrollController Called");
      setState(() {});
      showUploadedShortsController.loadMoreData();
    }
  }

  @override
  void dispose() {
    // scrollController.dispose();
    showUploadedShortsController.reelsItems.clear();
    showUploadedShortsController.start = 1;
    super.dispose();
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      showUploadedShortsController.start = 1;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUploadedShortsController.getReels();
      });
    });
  }

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: PrimaryRoundButton(
                          onTaped: () {
                            Get.back();
                          },
                          icon: Icons.arrow_back_rounded),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: GeneralTitle(title: St.shorts.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed("/CreateShort");
                        },
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image(
                              color: isDark.value ? MyColors.white : MyColors.darkGrey,
                              image: const AssetImage("assets/icons/Plus.png"),
                              height: 25,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: RefreshIndicator(
          onRefresh: () => refreshData(),
          child: GetBuilder<ShowUploadedShortsController>(
            builder: (ShowUploadedShortsController showUploadedShortsController) => showUploadedShortsController
                    .isLoading.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Shimmers.productGridviewShimmer(),
                  )
                : showUploadedShortsController.reelsItems.isEmpty
                    ? noDataFound(image: "assets/no_data_found/reels_not_found.png", text: St.noShortFound.tr)
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 20),
                                child: Text(St.uploadedShort.tr,
                                    style: GoogleFonts.plusJakartaSans(fontSize: 17, fontWeight: FontWeight.w500)),
                              ),
                              GridView.builder(
                                controller: scrollController,
                                cacheExtent: 1000,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: showUploadedShortsController.reelsItems.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 15,
                                  crossAxisCount: 2,
                                  mainAxisExtent: 50 * 5,
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      var reelItem = showUploadedShortsController.reelsItems[index];
                                      Get.to(ShortsPreview    (
                                          ifUploadedReel: true,
                                          productImage: reelItem.productId!.mainImage,
                                          productDescription: reelItem.description,
                                          productName: reelItem.productId!.productName,
                                          productPrice: reelItem.productId!.price.toString(),
                                          attributesArray: jsonDecode(jsonEncode(reelItem.productId!.attributes)),
                                          videoUrl: reelItem.video));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: isDark.value ? MyColors.lightBlack : MyColors.dullWhite,
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: SizedBox(
                                                  height: 180,
                                                  width: double.maxFinite,
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: [
                                                      CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl: showUploadedShortsController
                                                            .reelsItems[index].productId!.mainImage
                                                            .toString(),
                                                        placeholder: (context, url) => const Center(
                                                            child: CupertinoActivityIndicator(
                                                          animating: true,
                                                        )),
                                                        errorWidget: (context, url, error) =>
                                                            const Center(child: Icon(Icons.error)),
                                                      ),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: Icon(Icons.play_arrow_rounded,
                                                              color: MyColors.white, size: 50))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8, left: 8),
                                                child: Text(
                                                  showUploadedShortsController.reelsItems[index].productId!.productName
                                                      .toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 7, left: 8),
                                                child: Text(
                                                  "\$${showUploadedShortsController.reelsItems[index].productId!.price}",
                                                  style: GoogleFonts.plusJakartaSans(
                                                      color: MyColors.primaryPink,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.defaultDialog(
                                                  backgroundColor:
                                                      isDark.value ? MyColors.blackBackground : MyColors.white,
                                                  title: St.kindlyVerifyYourDecisionToDeleteTheShort.tr,
                                                  titlePadding: const EdgeInsets.only(top: 35),
                                                  titleStyle: GoogleFonts.plusJakartaSans(
                                                      color: isDark.value ? MyColors.white : MyColors.black,
                                                      height: 1.5,
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w600),
                                                  content: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: Get.height / 30,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                                        child: PrimaryPinkButton(
                                                            onTaped: () {
                                                              Get.back();
                                                            },
                                                            text: St.cancelSmallText.tr),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 18, bottom: 10),
                                                        child: SizedBox(
                                                          height: 20,
                                                          child: Obx(
                                                            () => manageShortsController.deleteReelLoading.value
                                                                ? const CupertinoActivityIndicator()
                                                                : GestureDetector(
                                                                    onTap: () async {
                                                                      manageShortsController.deleteReel(
                                                                          reelId:
                                                                              "${showUploadedShortsController.reelsItems[index].id}");
                                                                    },
                                                                    child: Text(
                                                                      St.delete.tr,
                                                                      style: GoogleFonts.plusJakartaSans(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 14,
                                                                          color: Colors.red),
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 31,
                                                width: 31,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isDark.value ? MyColors.blackBackground : MyColors.white),
                                                child: Image.asset("assets/icons/Delete.png").paddingAll(7.2),
                                              ).paddingOnly(bottom: 8, right: 8),
                                            ),
                                          )
                                        ],
                                      ),
                                    ).paddingOnly(bottom: 10),
                                  );
                                },
                              ),
                            ],
                          ).paddingOnly(bottom: 20),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
