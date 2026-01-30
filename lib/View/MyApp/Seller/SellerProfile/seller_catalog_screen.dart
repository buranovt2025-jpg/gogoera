import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/ApiControllers/seller/show_catalog_controller.dart';
import 'package:era_shop/View/MyApp/Seller/seller_profile.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerCatalogScreen extends StatefulWidget {
  const SellerCatalogScreen({super.key});

  @override
  State<SellerCatalogScreen> createState() => _SellerCatalogScreenState();
}

class _SellerCatalogScreenState extends State<SellerCatalogScreen> {
  ShowCatalogController showCatalogController = Get.put(ShowCatalogController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      log("scrollController");
      _scrollListener();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCatalogController.getCatalogData();
    });
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      log("ScrollController Called");
      setState(() {});
      showCatalogController.loadMoreData();
    }
  }

  @override
  void dispose() {
    showCatalogController.catalogItems.clear();
    showCatalogController.start = 1;
    super.dispose();
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      showCatalogController.start = 1;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCatalogController.getCatalogData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log("IS UPDATE OR NOT :: $isUpdateProductRequest");
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => const SellerProfile(), transition: Transition.leftToRight);
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: PrimaryRoundButton(
                            onTaped: () {
                              Get.off(() => const SellerProfile(), transition: Transition.leftToRight);
                              // Get.back();
                            },
                            icon: Icons.arrow_back_rounded),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: GeneralTitle(title: St.catalog.tr),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: GestureDetector(
                          onTap: () {
                            Get.offNamed("/AddProduct");
                            // Get.toNamed("/AddProduct");
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
            onRefresh: refreshData,
            child: Stack(
              children: [
                Obx(() => showCatalogController.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Shimmers.productGridviewShimmer(),
                      )
                    : showCatalogController.catalogItems.isEmpty
                        ? noDataFound(image: "assets/no_data_found/basket.png", text: St.noProductFound.tr)
                        : GetBuilder<ShowCatalogController>(
                            builder: (ShowCatalogController showCatalogController) {
                              return GridView.builder(
                                controller: scrollController,
                                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                                cacheExtent: 5000,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: showCatalogController.catalogItems.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 14,
                                  crossAxisCount: 2,
                                  mainAxisExtent: 49.2 * 5,
                                ),
                                itemBuilder: (context, index) {
                                  var catalogItems = showCatalogController.catalogItems[index];
                                  return GestureDetector(
                                    onTap: () {
                                      productId = "${catalogItems.id}";
                                      Get.offNamed("/SellerProductDetails");
                                    },
                                    child: SizedBox(
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  height: 190,
                                                  width: double.maxFinite,
                                                  fit: BoxFit.cover,
                                                  imageUrl: catalogItems.mainImage.toString(),
                                                  placeholder: (context, url) => const Center(
                                                      child: CupertinoActivityIndicator(
                                                    animating: true,
                                                  )),
                                                  errorWidget: (context, url, error) =>
                                                      const Center(child: Icon(Icons.error)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 7),
                                                child: Text(
                                                  catalogItems.productName!.capitalizeFirst.toString(),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 7),
                                                child: Text(
                                                  "\$${catalogItems.price}",
                                                  style: GoogleFonts.plusJakartaSans(
                                                      fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          isUpdateProductRequest == true
                                              ? (catalogItems.createStatus == "Pending") ||
                                                      (catalogItems.updateStatus == "Pending")
                                                  ? Container(
                                                      height: 23,
                                                      width: Get.width / 5.1,
                                                      decoration: BoxDecoration(
                                                          color: MyColors.primaryGreen,
                                                          borderRadius: const BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(5))),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Image.asset("assets/icons/pending_product.png",
                                                              height: 16),
                                                          Text(
                                                            St.pending.tr,
                                                            style: GoogleFonts.plusJakartaSans(
                                                                fontSize: 10,
                                                                color: MyColors.white,
                                                                fontWeight: FontWeight.w500),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : (catalogItems.createStatus == "Rejected") ||
                                                          (catalogItems.updateStatus == "Rejected")
                                                      ? Container(
                                                          height: 23,
                                                          width: Get.width / 5,
                                                          decoration: BoxDecoration(
                                                              color: MyColors.primaryRed,
                                                              borderRadius: const BorderRadius.only(
                                                                  topLeft: Radius.circular(10),
                                                                  bottomRight: Radius.circular(5))),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Image.asset("assets/icons/cancle_product_icon.png",
                                                                  height: 16),
                                                              Text(
                                                                St.rejected.tr,
                                                                style: GoogleFonts.plusJakartaSans(
                                                                    fontSize: 10,
                                                                    color: MyColors.white,
                                                                    fontWeight: FontWeight.w500),
                                                              ).paddingOnly(right: 5)
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox()
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Obx(
                      () => showCatalogController.moreLoading.value
                          ? Container(
                              height: 55,
                              width: 55,
                              decoration:
                                  BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.40)),
                              child: const Center(
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
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
