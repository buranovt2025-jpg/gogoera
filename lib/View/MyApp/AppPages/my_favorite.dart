import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/GetxController/user/new_collection_controller.dart';
import 'package:era_shop/Controller/GetxController/user/show_favorite_controller.dart';
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
import '../../../Controller/GetxController/user/get_all_category_controller.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({Key? key}) : super(key: key);

  @override
  State<MyFavorite> createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> with TickerProviderStateMixin {
  ShowFavoriteController showFavoriteController = Get.put(ShowFavoriteController());
  GetAllCategoryController getAllCategoryController = Get.put(GetAllCategoryController());
  NewCollectionController addToFavoriteController = Get.put(NewCollectionController());

  // late final TabController tabController;

  // @override
  // void initState() {
  //   super.initState();
  // showFavoriteController.getFavoriteData();
  // await getAllCategoryController.getCategory();
  //     .then((value) => tabBarLength())
  //     .then((value) => _handleTabChange());
  // tabController.addListener(() {
  //   _handleTabChange();
  // });
  // }

  // void tabBarLength() {
  //   tabController = TabController(length: getAllCategoryController.getAllCategory!.category!.length, vsync: this);
  //   log("Category length :: ${getAllCategoryController.getAllCategory!.category!.length}");
  // }

  // void _handleTabChange() {
  //   setState(() {
  //     int selectedIndex = tabController.index;
  //     log("Selected Index :: $selectedIndex");
  //     String selectedCategory = getAllCategoryController.getAllCategory!.category![selectedIndex].id.toString();
  //     log("Selected category :: $selectedCategory");
  //     showFavoriteController.getFavoriteData(selectCategory: selectedCategory);
  //   });
  // }

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
                      child: GeneralTitle(title: St.myFavorite.tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
// flexibleSpace: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: SizedBox(
      //     height: 40,
      //     child: Obx(
      //       () => getAllCategoryController.isLoading.value
      //           ? Shimmers.tabBarShimmer()
      //           : TabBar(
      //               controller: tabController,
      //               physics: const BouncingScrollPhysics(),
      //               padding: const EdgeInsets.only(left: 15, top: 12),
      //               indicator:
      //                   BoxDecoration(color: MyColors.primaryPink, borderRadius: BorderRadius.circular(6)),
      //               isScrollable: getAllCategoryController.getAllCategory!.category!.length > 4 ? true : false,
      //               unselectedLabelColor: isDark.value ? MyColors.white : MyColors.black,
      //               unselectedLabelStyle: GoogleFonts.plusJakartaSans(
      //                 color: MyColors.white,
      //               ),
      //               tabs: getAllCategoryController.getAllCategory!.category!
      //                   .map((category) => Tab(text: category.name))
      //                   .toList()),
      //     ),
      //   ).paddingOnly(bottom: 8),
      // ),
      body: SafeArea(
          child: Obx(
        () => showFavoriteController.isLoading.value /*|| getAllCategoryController.isLoading.value*/
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Shimmers.wishListShimmer(),
              )
            : showFavoriteController.favoriteProducts.isEmpty
                ? noDataFound(image: "assets/no_data_found/basket.png", text: St.wishListIsEmpty.tr)
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: showFavoriteController.favoriteProducts.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: SizedBox(
                          height: 120,
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      height: double.maxFinite,
                                      width: Get.width / 4.3,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          showFavoriteController.favoriteProducts[index].mainImage.toString(),
                                      placeholder: (context, url) => const Center(
                                          child: CupertinoActivityIndicator(
                                        animating: true,
                                      )),
                                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: Get.width / 2.3,
                                                  // color: Colors.amber,
                                                  child: Text(
                                                    showFavoriteController.favoriteProducts[index].productName,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 16, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${showFavoriteController.favoriteProducts[index].price}",
                                              // "\$${showFavoriteController.favoriteItems!.favorite![index].product![0].price}",
                                              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12),
                                              child: Text(
                                                showFavoriteController.favoriteProducts[index].subCategory,
                                                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w300),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: GestureDetector(
                                            onTap: () {
                                              productId = showFavoriteController.favoriteProducts[index].id;
                                              Get.toNamed("/ProductDetail");
                                            },
                                            child: Container(
                                              height: 29,
                                              width: Get.width / 3.6,
                                              decoration: BoxDecoration(
                                                color: MyColors.primaryPink,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Text("Add to cart",
                                                    style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 12, color: MyColors.white)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5, right: 15),
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        showFavoriteController.favoriteProducts.removeAt(index);

                                        log("Product ID ${showFavoriteController.favoriteItems!.favorite![index].product![0].id}");
                                        log("Category  ID ${showFavoriteController.favoriteItems!.favorite![index].categoryId}");

                                        addToFavoriteController.postFavoriteData(
                                            productId:
                                                "${showFavoriteController.favoriteItems!.favorite![index].product![0].id}",
                                            categoryId:
                                                "${showFavoriteController.favoriteItems!.favorite![index].categoryId}");
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: isDark.value
                                            ? Colors.white.withOpacity(0.30)
                                            : const Color(0xffeceded),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
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
    );
  }
}

/// if category wise show data in wishlist
// TabBarView(
// physics: const BouncingScrollPhysics(),
// controller: tabController,
// children: getAllCategoryController.getAllCategory!.category!.map((e) {
// return
