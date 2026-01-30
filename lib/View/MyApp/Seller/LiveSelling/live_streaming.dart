import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/ApiControllers/seller/show_catalog_controller.dart';
import 'package:era_shop/Controller/GetxController/seller/live_select_product_controller.dart';
import 'package:era_shop/View/MyApp/Seller/seller_profile.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Zego/create_engine.dart';
import 'package:era_shop/utiles/app_circular.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Controller/GetxController/seller/live_seller_for_selling_controller.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import '../../../../utiles/CoustomWidget/jump_to_live.dart';
import '../../../../utiles/Zego/ZegoUtils/permission.dart';
import '../../../../utiles/shimmers.dart';

class LiveStreaming extends StatefulWidget {
  const LiveStreaming({Key? key}) : super(key: key);

  @override
  State<LiveStreaming> createState() => _LiveStreamingState();
}

class _LiveStreamingState extends State<LiveStreaming> with TickerProviderStateMixin {
  ShowCatalogController showCatalogController = Get.put(ShowCatalogController());
  LiveSelectProductController liveSelectProductController = Get.put(LiveSelectProductController());
  LiveSellerForSellingController liveSellerForSellingController = Get.put(LiveSellerForSellingController());
  ScrollController scrollController = ScrollController();

  bool isNavigate = false;

  final List<bool> selected = List.generate(100000, (_) => false);

  @override
  void initState() {
    scrollController.addListener(() {
      log("scrollController");
      _scrollListener();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCatalogController.getCatalogData();
      isDemoSeller == true ? requestPermission() : null;
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(const SellerProfile(), transition: Transition.leftToRight);
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: PrimaryPinkButton(
                  onTaped: () async {
                    // createEngine();

                    await liveSellerForSellingController.sellerLiveForSelling();
                    var liveSellerData = liveSellerForSellingController.liveSellerForSelling?.liveseller;

                    log("liveSellingHistoryId :: ${liveSellerData!.liveSellingHistoryId}");
                    log("localUserID :: ${liveSellerData.sellerId}");
                    log("localUserName :: ${liveSellerData.firstName}");
                    liveSellerForSellingController.liveSellerForSelling!.status == true
                        // ignore: use_build_context_synchronously
                        ? jumpToLivePage(
                            context,
                            roomID: "${liveSellerData.liveSellingHistoryId}",
                            isHost: true,
                            localUserID: "${liveSellerData.sellerId}",
                            localUserName: "${liveSellerData.firstName}",
                          )
                        : displayToast(message: St.somethingWentWrong.tr);

                  },
                  text: St.goLive.tr),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: PrimaryRoundButton(
                                onTaped: () {
                                  Get.off(const SellerProfile(), transition: Transition.leftToRight);
                                  // Get.back();
                                },
                                icon: Icons.arrow_back_rounded),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: GeneralTitle(title: St.liveStemming.tr),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: GestureDetector(
                              onTap: () {
                                Get.offNamed("/AddProduct", arguments: isNavigate = true);
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
              child: Obx(
                () => showCatalogController.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Shimmers.productGridviewShimmer(),
                      )
                    : showCatalogController.catalogItems.isEmpty
                        ? noDataFound(image: "assets/no_data_found/basket.png", text: St.noProductFound.tr)
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 20),
                                    child: Text(St.selectProduct.tr,
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 17, fontWeight: FontWeight.w500)),
                                  ),
                                  GridView.builder(
                                    controller: scrollController,
                                    cacheExtent: 1000,
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: showCatalogController.catalogItems.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 15,
                                      crossAxisCount: 2,
                                      mainAxisExtent: 49.2 * 5,
                                    ),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected[index] = !selected[index];

                                            productId = "${showCatalogController.catalogItems[index].id}";

                                            selected[index]
                                                ? liveSelectProductController.getSelectedProductData()
                                                : !selected[index];

                                            !selected[index]
                                                ? liveSelectProductController.getSelectedProductData()
                                                : selected[index];

                                            selected[index] == true
                                                ? showCatalogController.selectedCatalogId
                                                    .add(showCatalogController.catalogItems[index].id)
                                                : showCatalogController.selectedCatalogId
                                                    .remove(showCatalogController.catalogItems[index].id);
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    height: 180,
                                                    width: double.maxFinite,
                                                    fit: BoxFit.cover,
                                                    imageUrl: showCatalogController.catalogItems[index].mainImage
                                                        .toString(),
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
                                                    showCatalogController.catalogItems[index].productName
                                                        .toString(),
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
                                                    "\$${showCatalogController.catalogItems[index].price}",
                                                    style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 14, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image(
                                                  image: showCatalogController.catalogItems[index].isSelect ==
                                                          true & selected[index]
                                                      ? const AssetImage("assets/icons/round check.png")
                                                      : const AssetImage("assets/icons/round_cheak_selected.png"),
                                                  height: 20,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
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
          Obx(
            () => liveSellerForSellingController.isLoading.value
                ? ScreenCircular.blackScreenCircular()
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
