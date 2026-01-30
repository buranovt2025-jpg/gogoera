import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:era_shop/Controller/GetxController/user/add_product_to_cart_controller.dart';
import 'package:era_shop/Controller/GetxController/user/follow_unfollow_controller.dart';
import 'package:era_shop/Controller/GetxController/user/user_product_details_controller.dart';
import 'package:era_shop/View/MyApp/AppPages/bottom_tab_bar.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Controller/GetxController/seller/selected_product_for_live_controller.dart';
import '../../../Controller/GetxController/user/new_collection_controller.dart';
import '../../../Controller/GetxController/user/remove_all_product_from_cart_controller.dart';
import '../../../utiles/shimmers.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  UserProductDetailsController userProductDetailsController = Get.put(UserProductDetailsController());
  FollowUnFollowController followUnFollowController = Get.put(FollowUnFollowController());
  AddProductToCartController addProductToCartController = Get.put(AddProductToCartController());
  NewCollectionController addToFavoriteController = Get.put(NewCollectionController());
  SelectedProductForLiveController selectedProductForLiveController = Get.put(SelectedProductForLiveController());
  RemoveAllProductFromCartController removeAllProductFromCartController = Get.put(RemoveAllProductFromCartController());

  bool isFollow = true;
  bool isLiked = false;
  bool isOneTimePress = false;
  final productController = PageController();
  int click = 0;
  int click1 = 0;

  final categoryDropdownController = DropdownController();

  Map<String, DropdownController> dropdownControllers = {};

  Map<String, String> selectedValues = {};

  addToCart() {
    addProductToCartController.isLoading.value = true;

    List<Map<String, String>> attributesArray = selectedValues.entries.map((entry) {
      return {
        "name": entry.key,
        "value": entry.value,
      };
    }).toList();

    addProductToCartController.addProductToCartData(
      productQuantity: 1,
      attributes: attributesArray,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    userProductDetailsController.userProductDetailsData();
    super.initState();
  }

  bool areAllAttributesFilled = false;
  void _showBottomSheet(BuildContext context, String key, List<CoolDropdownItem<String>> dropdownItems) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        // Calculate total height based on the number of items
        double totalHeight = dropdownItems.length * 50.0; // Adjust the factor as needed

        // Set a minimum height for the bottom sheet
        double minHeight = 200.0;

        // Ensure the height doesn't exceed the screen height
        double maxHeight = MediaQuery.of(ctx).size.height * 0.7;

        // Set the actual height of the bottom sheet
        double sheetHeight = totalHeight.clamp(minHeight, maxHeight);

        return Container(
          height: sheetHeight,
          child: ListView.builder(
            itemCount: dropdownItems.length,
            itemBuilder: (ctx, index) {
              final item = dropdownItems[index];
              return ListTile(
                title: Text(item.label),
                onTap: () {
                  setState(() {
                    selectedValues[key] = item.value;
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                          child: GeneralTitle(
                            title: St.productDetails.tr,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GestureDetector(
              onTap: () async {
                if (addProductToCartController.isAddToCart.isFalse) {
                  if (areAllAttributesFilled != true) {
                    displayToast(message: St.pleaseFillAllAttributes.tr);
                  } else {
                    await addToCart();
                    if (addProductToCartController.addProductToCart?.status == true) {
                      Get.dialog(Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: MyColors.primaryPink,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    St.addToCart.tr,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset("assets/icons/add-to-shopping-cart2.png", height: 200)
                                  .paddingSymmetric(vertical: 8),
                              Text(
                                St.congratulationYourOrderHasBeenDelivered.tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: MyColors.darkGrey,
                                ),
                              ).paddingSymmetric(horizontal: 15),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  width: Get.width / 2,
                                  decoration: BoxDecoration(
                                      color: MyColors.primaryPink, borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Text(
                                      St.remove.tr,
                                      style: GoogleFonts.plusJakartaSans(
                                          color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ).paddingSymmetric(vertical: 15)
                            ],
                          ),
                        ),
                      ));
                    } else {
                      Get.dialog(Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: MyColors.primaryPink,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    St.addToCart.tr,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset("assets/icons/add-to-shopping-cart2.png", height: 200)
                                  .paddingSymmetric(vertical: 8),
                              Text(
                                St.onlyOneSellersProductsAddedToCartAtATimeCanWeRemoveIt.tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: MyColors.darkGrey,
                                ),
                              ).paddingSymmetric(horizontal: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => removeAllProductFromCartController
                                        .deleteAllCartProduct()
                                        .then((value) => Get.back())
                                        .then((value) => addToCart()),
                                    child: Container(
                                      height: 50,
                                      width: Get.width / 3,
                                      decoration: BoxDecoration(
                                          color: MyColors.primaryPink, borderRadius: BorderRadius.circular(16)),
                                      child: Center(
                                        child: Text(
                                          St.remove.tr,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ).paddingOnly(right: 13),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: Get.width / 3,
                                      decoration: BoxDecoration(
                                          color: MyColors.primaryPink, borderRadius: BorderRadius.circular(16)),
                                      child: Center(
                                        child: Text(
                                          St.cancelSmallText.tr,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ).paddingSymmetric(vertical: 15)
                            ],
                          ),
                        ),
                      ));
                    }
                  }
                } else {
                  Get.offAll(BottomTabBar(
                    index: 3,
                  ));
                }
              },
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                    color: areAllAttributesFilled == false ? MyColors.darkGrey.withOpacity(0.40) : MyColors.primaryPink,
                    borderRadius: BorderRadius.circular(24)),
                child: Center(
                  child: Obx(
                    () => Text(
                      addProductToCartController.isAddToCart.isFalse ? St.addToCart.tr : St.goToCart.tr,
                      style: GoogleFonts.plusJakartaSans(
                          color: areAllAttributesFilled == false ? MyColors.darkGrey : MyColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
              child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Obx(
              () => userProductDetailsController.isLoading.value
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
                                        userProductDetailsController.userProductDetails!.product?[0].images!.length,
                                    onPageChanged: (value) {
                                      setState(() {});
                                      click1 = value;
                                    },
                                    itemBuilder: (context, index) {
                                      return CachedNetworkImage(
                                        height: double.maxFinite,
                                        width: double.maxFinite,
                                        fit: BoxFit.fitHeight,
                                        imageUrl: userProductDetailsController
                                            .userProductDetails!.product![0].images![index]
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
                                child: Row(
                                  children: [
                                    Text(
                                      "\$${userProductDetailsController.userProductDetails!.product![0].price}",
                                      style: GoogleFonts.plusJakartaSans(fontSize: 23, fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: userProductDetailsController
                                                  .userProductDetails!.product![0].shippingCharges ==
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
                                                "${St.deliveryCharge.tr} : \$${userProductDetailsController.userProductDetails!.product![0].shippingCharges}",
                                                style: GoogleFonts.plusJakartaSans(
                                                    color: MyColors.white, fontSize: 13, fontWeight: FontWeight.w500),
                                              ).paddingSymmetric(horizontal: 10)),
                                            ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isLiked = !isLiked;
                                        });
                                        addToFavoriteController.postFavoriteData(
                                            productId: productId,
                                            categoryId:
                                                "${userProductDetailsController.userProductDetails!.product![0].category!.id}");
                                      },
                                      child: Container(
                                        height: 46,
                                        width: 46,
                                        decoration: BoxDecoration(
                                          color: isDark.value
                                              ? MyColors.darkGrey.withOpacity(0.10)
                                              : const Color(0xffF6F8FE),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(13),
                                          child: isDark.value
                                              ? Image(
                                                  image: userProductDetailsController
                                                              .userProductDetails!.product![0].isFavorite ==
                                                          true & isLiked
                                                      ? AssetImage(AppImage.greyUnselectedHeart)
                                                      : AssetImage(AppImage.redHeart),
                                                )
                                              : Image(
                                                  image: userProductDetailsController
                                                              .userProductDetails!.product![0].isFavorite ==
                                                          true & isLiked
                                                      ? AssetImage(AppImage.blackUnselectedHeart)
                                                      : AssetImage(AppImage.redHeart),
                                                ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  userProductDetailsController.userProductDetails!.product![0].productName.toString(),
                                  style: GoogleFonts.plusJakartaSans(fontSize: 19, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Row(
                                  children: [
                                    userProductDetailsController
                                                    .userProductDetails!.product![0].seller?.address?.city !=
                                                null ||
                                            userProductDetailsController
                                                    .userProductDetails!.product![0].seller?.address?.country !=
                                                null
                                        ? SizedBox(
                                            child: Row(
                                              children: [
                                                Image(
                                                  color: isDark.value ? MyColors.white : MyColors.black,
                                                  image: AssetImage(AppImage.location),
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 7),
                                                  child: Text(
                                                    "${userProductDetailsController.userProductDetails!.product![0].seller?.address?.city},${userProductDetailsController.userProductDetails!.product![0].seller?.address?.country}",
                                                    style: GoogleFonts.plusJakartaSans(
                                                        color: isDark.value ? MyColors.white : const Color(0xff434E58),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: SizedBox(
                                        child: Row(
                                          children: [
                                            Image(
                                              color: isDark.value ? MyColors.white : MyColors.black,
                                              image: AssetImage(AppImage.cart),
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 7),
                                              child: Text(
                                                "${userProductDetailsController.userProductDetails!.product![0].sold} ${St.sold.tr}",
                                                style: GoogleFonts.plusJakartaSans(
                                                    color: isDark.value ? MyColors.white : const Color(0xff434E58),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xffFACC15),
                                      size: 23,
                                    ),
                                    Text(
                                      userProductDetailsController.userProductDetails!.product![0].rating!.isEmpty
                                          ? "0(0)"
                                          : "${userProductDetailsController.userProductDetails!.product![0].rating?[0].avgRating}.0 (${userProductDetailsController.userProductDetails!.product![0].rating?[0].totalUser})",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: isDark.value ? MyColors.white : const Color(0xff434E58),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: MyColors.darkGrey.withOpacity(0.30),
                                  thickness: 1.2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                child: Column(
                                  children: userProductDetailsController.selectedValuesByType.keys.map((key) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        key.capitalizeFirst.toString() == "Colors"
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3),
                                                child: Text(
                                                  "${key.capitalizeFirst.toString()}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.plusJakartaSans(
                                                      fontSize: 16, fontWeight: FontWeight.w600),
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3),
                                                child: Text(
                                                  selectedValues[key] != null
                                                      ? "${key.capitalizeFirst.toString()} : ${selectedValues[key]}"
                                                      : key.capitalizeFirst.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.plusJakartaSans(
                                                      fontSize: 16, fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          child: SizedBox(
                                            height: Get.width * 0.14,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: userProductDetailsController.selectedValuesByType[key]!.length,
                                              itemBuilder: (context, index) {
                                                final value =
                                                    userProductDetailsController.selectedValuesByType[key]![index];
                                                final isSelected = selectedValues[key] == value;

                                                return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedValues[key] = value;
                                                        log("selectedValues  $selectedValues");
                                                        List<Map<String, String>> selectedValueList = selectedValues
                                                            .entries
                                                            .map((entry) => {entry.key: entry.value})
                                                            .toList();

                                                        log("selectedValueList :: $selectedValueList");
                                                        // aa value api ma moklwani thashe
                                                        log("selectedValueList Json String :: ${jsonEncode(selectedValueList)}");

                                                        bool allAttributesFilled = userProductDetailsController
                                                            .selectedValuesByType.keys
                                                            .every((key) => selectedValues[key] != null);
                                                        setState(() {
                                                          areAllAttributesFilled = allAttributesFilled;
                                                          log("Attrubutes Filled :: $areAllAttributesFilled");
                                                        });
                                                        log("All attributr selected or not :: $areAllAttributesFilled");
                                                      });

                                                      // setState(() {
                                                      //   if (isSelected) {
                                                      //     selectedValues[key] = "";
                                                      //   } else {
                                                      //     selectedValues[key] = value;
                                                      //   }
                                                      // });
                                                    },
                                                    child: key.capitalizeFirst.toString() == "Colors"
                                                        ? Container(
                                                            height: Get.width * 0.12,
                                                            width: Get.width * 0.12,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border: Border.all(
                                                                  color: isSelected
                                                                      ? MyColors.primaryPink
                                                                      : Colors.transparent,
                                                                  width: 2,
                                                                )),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      Color(int.parse(value.replaceAll("#", "0xFF"))),
                                                                  shape: BoxShape.circle),
                                                            ).paddingAll(2),
                                                          ).paddingOnly(right: 6)
                                                        : Container(
                                                            alignment: Alignment.center,
                                                            height: Get.width * 0.13,
                                                            width: Get.width * 0.13,
                                                            padding: const EdgeInsets.symmetric(
                                                                vertical: 10, horizontal: 10),
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: isSelected
                                                                  ? MyColors.primaryPink
                                                                  : Colors.transparent,
                                                              // borderRadius: BorderRadius.circular(10),
                                                              border: Border.all(
                                                                color: isSelected
                                                                    ? MyColors.primaryPink
                                                                    : MyColors.mediumGrey,
                                                              ),
                                                            ),
                                                            child: FittedBox(
                                                              child: Text(
                                                                value,
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: isDark.value
                                                                      ? MyColors.white
                                                                      : isSelected
                                                                          ? Colors.white
                                                                          : Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ).paddingOnly(right: 10));
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: GeneralTitle(
                                  title: St.productDetails.tr,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
                                            itemCount: userProductDetailsController
                                                .userProductDetails!.product![0].attributes!.length,
                                            itemBuilder: (context, index) {
                                              return Text(
                                                "${userProductDetailsController.userProductDetails!.product![0].attributes![index].name.toString().capitalizeFirst}",
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
                                            userProductDetailsController
                                                        .userProductDetails!.product![0].isNewCollection ==
                                                    true
                                                ? St.newCollection.tr
                                                : St.trendingCollection.tr,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                GoogleFonts.plusJakartaSans(fontSize: 15, color: MyColors.primaryPink),
                                          ),
                                          Text(
                                            userProductDetailsController.userProductDetails!.product![0].category!.name
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                GoogleFonts.plusJakartaSans(fontSize: 15, color: MyColors.primaryPink),
                                          ).paddingSymmetric(vertical: 13),
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: userProductDetailsController
                                                .userProductDetails!.product![0].attributes!.length,
                                            itemBuilder: (context, index) {
                                              var attributes = userProductDetailsController
                                                  .userProductDetails!.product![0].attributes![index];
                                              print(
                                                  "::::::::::::${userProductDetailsController.userProductDetails!.product![0].attributes![index].value?[0]}");
                                              return Align(
                                                alignment: Alignment.centerLeft,
                                                child: userProductDetailsController
                                                            .userProductDetails!.product![0].attributes?[index].name ==
                                                        "Colors"
                                                    ? Row(
                                                        children: [
                                                          for (int i = 0; i < attributes.value!.length; i++)
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color: Color(int.parse(
                                                                      attributes.value![i].replaceAll("#", "0xFF"))),
                                                                  shape: BoxShape.circle),
                                                            ).paddingOnly(left: 6, bottom: 4),
                                                        ],
                                                      )

                                                    // ?Text("data")
                                                    : Text(
                                                        userProductDetailsController
                                                            .userProductDetails!.product![0].attributes![index].value!
                                                            .join(", "),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.plusJakartaSans(
                                                          fontSize: 15,
                                                          color: MyColors.primaryPink,
                                                        ),
                                                      ).paddingOnly(bottom: 13),
                                              );
                                            },
                                          ),
                                          Text(
                                            userProductDetailsController.userProductDetails!.product![0].isOutOfStock ==
                                                    true
                                                ? St.outOfStock.tr
                                                : St.inStock.tr,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                GoogleFonts.plusJakartaSans(fontSize: 15, color: MyColors.primaryPink),
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
                                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                                  child: SizedBox(
                                    child: Text(
                                      userProductDetailsController.userProductDetails!.product![0].description
                                          .toString(),
                                      style: GoogleFonts.plusJakartaSans(fontSize: 15, height: 1.9),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: MyColors.darkGrey.withOpacity(0.30),
                                  thickness: 1.2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GeneralTitle(title: St.productReview.tr).paddingOnly(bottom: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xffFACC15),
                                              size: 23,
                                            ).paddingOnly(right: 5),
                                            Text(
                                              userProductDetailsController
                                                      .userProductDetails!.product![0].rating!.isEmpty
                                                  ? "0(0)"
                                                  : "${userProductDetailsController.userProductDetails!.product![0].rating?[0].avgRating}.0 (${userProductDetailsController.userProductDetails!.product![0].rating?[0].totalUser})",
                                              style: GoogleFonts.plusJakartaSans(
                                                  color: isDark.value ? MyColors.white : const Color(0xff434E58),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        productId =
                                            "${userProductDetailsController.userProductDetails!.product![0].id}";
                                        Get.toNamed("/ProductReviews");
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 80,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            St.seeAll.tr,
                                            style: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w600, fontSize: 15, color: MyColors.primaryPink),
                                          ),
                                        ),
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
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 21,
                                            backgroundImage: NetworkImage(
                                                "${userProductDetailsController.userProductDetails!.product![0].seller?.image.toString()}"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${userProductDetailsController.userProductDetails!.product![0].seller?.businessName}",
                                                  style: GoogleFonts.plusJakartaSans(
                                                      fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    "${userProductDetailsController.userProductDetails!.product![0].seller?.businessTag}",
                                                    style: GoogleFonts.plusJakartaSans(
                                                        color: isDark.value ? MyColors.white : const Color(0xff78828A),
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {});
                                        isFollow = !isFollow;
                                        followUnFollowController.followUnfollowData(
                                            sellerId: userProductDetailsController
                                                .userProductDetails!.product![0].seller!.id
                                                .toString());
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 76,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(11),
                                            border: Border.all(width: 1.3, color: MyColors.primaryPink)),
                                        child: Center(
                                            child: Text(
                                          userProductDetailsController.userProductDetails!.product![0].isFollow ==
                                                  true & isFollow
                                              ? St.unFollow.tr
                                              : St.follow.tr,
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600, fontSize: 12, color: MyColors.primaryPink),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
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
                                        userProductDetailsController.userProductDetails!.product?[0].images!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {});
                                            click = index;
                                            productController.jumpToPage(index);
                                          },
                                          child: Container(
                                            height: 65,
                                            width: 65,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: click1 == index ? MyColors.primaryPink : Colors.transparent),
                                                borderRadius: BorderRadius.circular(12)),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                height: 65,
                                                width: 65,
                                                fit: BoxFit.cover,
                                                imageUrl: userProductDetailsController
                                                    .userProductDetails!.product![0].images![index]
                                                    .toString(),
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
                                    count: userProductDetailsController.userProductDetails!.product![0].images!.length
                                        .toInt(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          )),
        ),
        Obx(
          () => addProductToCartController.isLoading.value
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.black54,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : const SizedBox(),
        )
      ],
    );
  }
}
