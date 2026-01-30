import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ApiModel/seller/ShowCatalogModel.dart';
import '../../../Controller/ApiControllers/seller/show_catalog_controller.dart';
import '../../../Controller/GetxController/seller/manage_reels_controller.dart';
import '../../Theme/my_colors.dart';
import '../../globle_veriables.dart';
import '../../shimmers.dart';
import '../App_theme_services/text_titles.dart';

class SelectProductWhenCreateReels extends StatefulWidget {
  const SelectProductWhenCreateReels({super.key});

  @override
  State<SelectProductWhenCreateReels> createState() => _SelectProductWhenCreateReelsState();
}

class _SelectProductWhenCreateReelsState extends State<SelectProductWhenCreateReels> {
  ShowCatalogController showCatalogController = Get.put(ShowCatalogController());
  ManageShortsController manageShortsController = Get.put(ManageShortsController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      log("scrollController");
      _scrollListener();
    });
    super.initState();
  }

  // Scroll listener callback
  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      log("ScrollController Called");
      setState(() {});
      showCatalogController.loadMoreData();
    }
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
    return Container(
      height: Get.height / 1.3,
      decoration: BoxDecoration(
          color: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25))),
      child: SizedBox(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                () => showCatalogController.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 75),
                        child: Shimmers.productGridviewShimmer(),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: GetBuilder<ShowCatalogController>(
                          builder: (ShowCatalogController showCatalogController) => GridView.builder(
                            cacheExtent: 1000,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 75),
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
                                    manageShortsController.selectedIndex = index;

                                    final List<Attributes>? attributesArray =
                                        showCatalogController.catalogItems[index].attributes;

                                    ///--------------------------------------------------
                                    manageShortsController.productId =
                                        showCatalogController.catalogItems[index].id;
                                    manageShortsController.sellerId =
                                        showCatalogController.catalogItems[index].seller!.id;
                                    manageShortsController.selectProductName.text =
                                        showCatalogController.catalogItems[index].productName.toString();
                                    manageShortsController.selectedProductDescription.text =
                                        showCatalogController.catalogItems[index].description.toString();
                                    manageShortsController.productPrice =
                                        showCatalogController.catalogItems[index].price.toString();
                                    manageShortsController.attributesArray =
                                        jsonDecode(jsonEncode(attributesArray));
                                    manageShortsController.productImage =
                                        showCatalogController.catalogItems[index].mainImage.toString();
                                    log("Attributes array :: ${manageShortsController.attributesArray![0]}");
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
                                            imageUrl:
                                                showCatalogController.catalogItems[index].mainImage.toString(),
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
                                            showCatalogController.catalogItems[index].productName.toString(),
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
                                        child: GetBuilder<ShowCatalogController>(
                                          builder: (showCatalogController) => Image(
                                            image: manageShortsController.selectedIndex == index
                                                ? const AssetImage("assets/icons/round_cheak_selected.png")
                                                : const AssetImage("assets/icons/round check.png"),
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                  color: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallTitle(title: St.addProduct.tr),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 30,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: MyColors.primaryPink, borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                    child: Text(
                                  St.done.tr,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12, color: MyColors.white, fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Obx(
                        () => Divider(
                          color: isDark.value ? MyColors.white : MyColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
