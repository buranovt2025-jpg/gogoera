import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/GetxController/seller/delete_catalog_controller.dart';
import 'package:era_shop/Controller/GetxController/seller/seller_product_detail_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../SellerProfile/seller_catalog_screen.dart';

class SellerProductDetails extends StatefulWidget {
  const SellerProductDetails({Key? key}) : super(key: key);

  @override
  State<SellerProductDetails> createState() => _SellerProductDetailsState();
}

class _SellerProductDetailsState extends State<SellerProductDetails> {
  SellerProductDetailsController sellerProductDetailsController = Get.put(SellerProductDetailsController());
  DeleteCatalogController deleteCatalogController = Get.put(DeleteCatalogController());

  final productController = PageController();
  int click = 0;
  int click1 = 0;

  @override
  void initState() {
    // TODO: implement initState
    // sellerProductDetailsController.selectedSize.clear();
    sellerProductDetailsController.getProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(const SellerCatalogScreen(), transition: Transition.leftToRight);
        // Get.back();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
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
                          Get.off(const SellerCatalogScreen(), transition: Transition.leftToRight);
                          // Get.back();
                        },
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.productDetails.tr,),
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
          child: Obx(
            () => sellerProductDetailsController.isLoading.value
                ? Shimmers.productDetailsShimmer()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: Get.height / 2.1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                clipBehavior: Clip.hardEdge,
                                child: PageView.builder(
                                  controller: productController,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      sellerProductDetailsController.sellerProductDetails!.product![0].images?.length,
                                  onPageChanged: (value) {
                                    setState(() {});
                                    click1 = value;
                                  },
                                  itemBuilder: (context, index) {
                                    return CachedNetworkImage(
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      fit: BoxFit.fitHeight,
                                      imageUrl: sellerProductDetailsController
                                          .sellerProductDetails!.product![0].images![index]
                                          .toString(),
                                      placeholder: (context, url) => const Center(
                                          child: CupertinoActivityIndicator(
                                        animating: true,
                                      )),
                                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                    );
                                  },
                                ),
                              ),
                            ).paddingSymmetric(horizontal: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                              child: Text(
                                sellerProductDetailsController.sellerProductDetails!.product![0].productName.toString(),
                                style: GoogleFonts.plusJakartaSans(fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "\$${sellerProductDetailsController.sellerProductDetails!.product![0].price}",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: sellerProductDetailsController
                                                .sellerProductDetails!.product![0].shippingCharges ==
                                            0
                                        ? Container(
                                            height: 30,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: MyColors.primaryGreen,
                                            ),
                                            child: Center(
                                                child: Text(
                                              St.freeShipping.tr,
                                              style: GoogleFonts.plusJakartaSans(color: MyColors.white, fontSize: 13),
                                            )),
                                          )
                                        : Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: MyColors.primaryRed,
                                            ),
                                            child: Center(
                                                child: Text(
                                              "${St.deliveryCharge.tr} : \$${sellerProductDetailsController.sellerProductDetails!.product![0].shippingCharges}",
                                              style: GoogleFonts.plusJakartaSans(
                                                  color: MyColors.white, fontSize: 13, fontWeight: FontWeight.w500),
                                            ).paddingSymmetric(horizontal: 10)),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                color: MyColors.darkGrey.withOpacity(0.30),
                                thickness: 1.2,
                                height: 40,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                              child: GeneralTitle(title: St.productDetails.tr,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 6),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width / 2.8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          St.product.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(fontSize: 15),
                                        ),
                                        Text(
                                          St.category.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(fontSize: 15),
                                        ).paddingSymmetric(vertical: 13),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: sellerProductDetailsController
                                              .sellerProductDetails!.product![0].attributes!.length,
                                          itemBuilder: (context, index) {
                                            return Text(
                                              "${sellerProductDetailsController.sellerProductDetails!.product![0].attributes![index].name.toString().capitalizeFirst}",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.plusJakartaSans(fontSize: 15),
                                            ).paddingOnly(bottom: 13);
                                          },
                                        ),
                                        Text(
                                          St.availability.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width / 2.2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          sellerProductDetailsController
                                                      .sellerProductDetails!.product![0].isNewCollection ==
                                                  true
                                              ? St.newCollection.tr
                                              : St.trendingCollection.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(fontSize: 15, color: MyColors.primaryPink),
                                        ),
                                        Text(
                                          sellerProductDetailsController
                                              .sellerProductDetails!.product![0].category!.name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(fontSize: 15, color: MyColors.primaryPink),
                                        ).paddingSymmetric(vertical: 10),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: sellerProductDetailsController
                                              .sellerProductDetails!.product![0].attributes!.length,
                                          itemBuilder: (context, index) {
                                            log("message:::${sellerProductDetailsController.sellerProductDetails!.product![0].attributes?[index].name}");
                                            log("message:::${sellerProductDetailsController.sellerProductDetails!.product![0].attributes?[index].value}");
                                            return sellerProductDetailsController
                                                        .sellerProductDetails!.product![0].attributes?[index].name ==
                                                    "colors"
                                                ? SizedBox(
                                                    height: 30,
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: sellerProductDetailsController.sellerProductDetails!
                                                            .product![0].attributes![index].value?.length,
                                                        itemBuilder: (context, i) {
                                                          print(
                                                              "object :::  ${sellerProductDetailsController.sellerProductDetails!.product![0].attributes![index].value![i]}");
                                                          return Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Color(int.parse(sellerProductDetailsController
                                                                  .sellerProductDetails!
                                                                  .product![0]
                                                                  .attributes![index]
                                                                  .value![i]
                                                                  .replaceAll("#", "0xFF"))),
                                                            ),
                                                          ).paddingOnly(right: 6);
                                                        },
                                                      ),
                                                    ),
                                                  ).paddingOnly(bottom: 10)
                                                : Text(
                                                    sellerProductDetailsController
                                                        .sellerProductDetails!.product![0].attributes![index].value!
                                                        .join(", "),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 15, color: MyColors.primaryPink),
                                                  ).paddingOnly(bottom: 13);
                                            return Text(
                                              sellerProductDetailsController
                                                  .sellerProductDetails!.product![0].attributes![index].value!
                                                  .join(", "),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 15, color: MyColors.primaryPink),
                                            ).paddingOnly(bottom: 13);
                                          },
                                        ),
                                        Text(
                                          sellerProductDetailsController
                                                      .sellerProductDetails!.product![0].isOutOfStock ==
                                                  true
                                              ? St.outOfStock.tr
                                              : St.inStock.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(fontSize: 15, color: MyColors.primaryPink),
                                        ),
                                      ],
                                    ),
                                  ).paddingOnly(left: 10),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: SizedBox(
                                  child: Text(
                                    sellerProductDetailsController.sellerProductDetails!.product![0].description
                                        .toString(),
                                    style: GoogleFonts.plusJakartaSans(fontSize: 15, height: 1.9),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                              child: PrimaryPinkButton(
                                  onTaped: isDemoSeller == true
                                      ? () => displayToast(message: St.thisIsDemoApp.tr)
                                      : () {
                                          log("createStatus :: ${sellerProductDetailsController.sellerProductDetails!.product![0].createStatus}");
                                          log("updateStatus :: ${sellerProductDetailsController.sellerProductDetails!.product![0].updateStatus}");
                                          log("Is update :: $isUpdateProductRequest");
                                          if (isUpdateProductRequest == true) {
                                            if ((sellerProductDetailsController
                                                        .sellerProductDetails!.product![0].createStatus ==
                                                    "Pending") ||
                                                (sellerProductDetailsController
                                                        .sellerProductDetails!.product![0].updateStatus ==
                                                    "Pending")) {
                                              displayToast(message: St.yourProductIsInPendingMode.tr);
                                            } else if ((sellerProductDetailsController
                                                        .sellerProductDetails!.product![0].createStatus ==
                                                    "Rejected") ||
                                                (sellerProductDetailsController
                                                        .sellerProductDetails!.product![0].updateStatus ==
                                                    "Rejected")) {
                                              displayToast(message: St.oppsYourProductHasBeenRejected.tr);
                                            } else {
                                              Get.toNamed("/EditProduct")?.then((value) {
                                                if (value != null) {
                                                  log("Then Called");
                                                  sellerProductDetailsController.getProductDetails();
                                                  // Perform any actions or update data if necessary
                                                }
                                              });
                                            }
                                          } else {
                                            Get.toNamed("/EditProduct")?.then((value) {
                                              if (value != null) {
                                                log("Then Called");
                                                sellerProductDetailsController.getProductDetails();
                                                // Perform any actions or update data if necessary
                                              }
                                            });
                                          }
                                        },
                                  text: St.editDetails.tr),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: PrimaryWhiteButton(
                                  onTaped: isDemoSeller == true
                                      ? () => displayToast(message: St.thisIsDemoApp.tr)
                                      : () {
                                          Get.defaultDialog(
                                            backgroundColor: isDark.value ? MyColors.blackBackground : MyColors.white,
                                            title: St.doYouReallyWantToRemoveThisProduct.tr,
                                            titlePadding: const EdgeInsets.only(top: 45, left: 20, right: 20),
                                            titleStyle: GoogleFonts.plusJakartaSans(
                                                color: isDark.value ? MyColors.white : MyColors.black,
                                                height: 1.4,
                                                fontSize: 18,
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
                                                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      deleteCatalogController.getDeleteData();
                                                      Get.back();
                                                      // Get.offNamed("/SellerCatalogScreen");
                                                    },
                                                    child: Text(
                                                      St.remove.tr,
                                                      style: GoogleFonts.plusJakartaSans(
                                                          fontWeight: FontWeight.w600, fontSize: 14, color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                  text: St.removeCatalog),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: EdgeInsets.only(top: Get.height / 8.5, right: 8),
                              child: SizedBox(
                                width: 80,
                                height: 240,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      sellerProductDetailsController.sellerProductDetails!.product![0].images?.length,
                                  itemBuilder: (context, index) {
                                    // attributes =  sellerProductDetailsController.sellerProductDetails!.product![0].attributes![index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {});
                                          click = index;
                                          productController.jumpToPage(index);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 65,
                                              width: 65,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          click1 == index ? MyColors.primaryPink : Colors.transparent),
                                                  borderRadius: BorderRadius.circular(12)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  height: 65,
                                                  width: 65,
                                                  fit: BoxFit.cover,
                                                  imageUrl: sellerProductDetailsController
                                                      .sellerProductDetails!.product![0].images![index],
                                                  placeholder: (context, url) => const Center(
                                                      child: CupertinoActivityIndicator(
                                                    radius: 7,
                                                    animating: true,
                                                  )),
                                                  errorWidget: (context, url, error) =>
                                                      const Center(child: Icon(Icons.error)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: Get.height / 2.4 + 3),
                            child: Container(
                              height: Get.height / 11,
                              color: Colors.transparent,
                              child: Center(
                                child: SmoothPageIndicator(
                                  effect: ExpandingDotsEffect(
                                      dotHeight: 8,
                                      dotWidth: 8,
                                      dotColor: Colors.grey.shade400,
                                      activeDotColor: MyColors.primaryPink),
                                  controller: productController,
                                  count:
                                      sellerProductDetailsController.sellerProductDetails!.product![0].images!.length,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
