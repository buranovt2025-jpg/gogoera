// ignore_for_file: must_be_immutable
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Controller/GetxController/user/previous_search_product_controller.dart';
import '../../../Controller/GetxController/user/user_search_product_controller.dart';
import '../../../utiles/CoustomWidget/Page_devided/filter_bottem_shit.dart';
import '../../../utiles/Theme/my_colors.dart';
import '../../../utiles/globle_veriables.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  UserSearchProductController userSearchProductController = Get.put(UserSearchProductController());
  PreviousSearchController previousSearchController = Get.put(PreviousSearchController());

  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isLoading = true;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  void searchProducts() async {
    final String searchTerm = searchController.text;
    if (searchTerm.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await userSearchProductController.userSearchProductDetailsData(productName: searchTerm);
      setState(() {
        userSearchProductController.isLoading.value = false;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    searchController.dispose();
    super.dispose();
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
                      child: GeneralTitle(title: St.searchTitle.tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height / 35, horizontal: 15),
                  child: SizedBox(
                    height: 56,
                    child: Obx(
                      () => TextFormField(
                        textInputAction: TextInputAction.search,
                        // keyboardType: TextInputType.none,
                        focusNode: _focusNode,
                        autofocus: true,
                        onFieldSubmitted: (value) {
                          searchProducts();
                        },
                        controller: searchController,
                        style: TextStyle(color: isDark.value ? MyColors.dullWhite : MyColors.black),
                        decoration: InputDecoration(
                            filled: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(17),
                              child: GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    isScrollControlled: true,
                                    const FilterBottomShirt(),
                                  );
                                },
                                child: Container(
                                  height: 100,
                                  width: 40,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.5),
                                    child: Image(
                                      image: AssetImage(AppImage.filterImage),
                                      color: isDark.value ? MyColors.white : MyColors.black,
                                      height: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                              child: Image(
                                image: AssetImage(AppImage.searchImage),
                                height: 8,
                                width: 10,
                              ),
                            ),
                            hintText: "${St.searchTitle.tr}...",
                            hintStyle: GoogleFonts.plusJakartaSans(color: const Color(0xff9CA4AB), fontSize: 17),
                            fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.primaryPink),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    userSearchProductController.userSearchProductModel?.products != null
                        ? userSearchProductController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : userSearchProductController.userSearchProductModel!.products!.isNotEmpty
                                ? /*GridView.builder(
                                    controller: scrollController,
                                    padding: const EdgeInsets.only(left: 15, right: 15),
                                    cacheExtent: 5000,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        userSearchProductController.userSearchProductModel?.products?.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 14,
                                      crossAxisCount: 2,
                                      mainAxisExtent: 49.2 * 5,
                                    ),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          productId =
                                              "${userSearchProductController.userSearchProductModel?.products![index].id}";
                                          Get.toNamed("/ProductDetail");
                                        },
                                        child: SizedBox(
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 190,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(userSearchProductController
                                                                .userSearchProductModel!.products![index].mainImage
                                                                .toString()),
                                                            fit: BoxFit.cover),
                                                        borderRadius: BorderRadius.circular(10)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 7),
                                                    child: Text(
                                                      userSearchProductController.userSearchProductModel!
                                                          .products![index].productName!.capitalizeFirst
                                                          .toString(),
                                                      style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 7),
                                                    child: Text(
                                                      "\$${userSearchProductController.userSearchProductModel!.products![index].price}",
                                                      style: GoogleFonts.plusJakartaSans(
                                                          fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )*/
                                ListView.builder(
                                    controller: scrollController,
                                    // padding: const EdgeInsets.only(left: 15, right: 15),
                                    // cacheExtent: 5000,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount:
                                        userSearchProductController.userSearchProductModel?.products?.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                        child: InkWell(
                                          onTap: () {
                                            productId =
                                                "${userSearchProductController.userSearchProductModel?.products![index].id}";
                                            Get.toNamed("/ProductDetail");
                                          },
                                          child: SizedBox(
                                            height: Get.height / 8.2,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: Get.width / 4.3,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(userSearchProductController
                                                              .userSearchProductModel!.products![index].mainImage
                                                              .toString()),
                                                          fit: BoxFit.cover),
                                                      borderRadius: BorderRadius.circular(15)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "${userSearchProductController.userSearchProductModel!.products![index].productName!.capitalizeFirst}",
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: GoogleFonts.plusJakartaSans(
                                                                  fontSize: 16, fontWeight: FontWeight.w500),
                                                            ),
                                                            // Padding(
                                                            //   padding: const EdgeInsets.only(top: 5),
                                                            //   child: SizedBox(
                                                            //       width: Get.width / 1.7,
                                                            //       child: Text(
                                                            //         "Size  ${justForYouProductController.justForYouProduct!.justForYouProducts![index].attributes![0].value!.join(", ")}",
                                                            //         overflow: TextOverflow.ellipsis,
                                                            //         style: GoogleFonts.plusJakartaSans(
                                                            //             fontWeight: FontWeight.w300),
                                                            //       )),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        "\$${userSearchProductController.userSearchProductModel!.products![index].price}",
                                                        style: GoogleFonts.plusJakartaSans(
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                :   Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(St.productNotFound.tr),
                                      ),
                                    ],
                                  )
                        : Visibility(
                            visible: userSearchProductController.isLoading.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: SmallTitle(title: St.lastSearch.tr),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 6),
                                  child: SizedBox(
                                    child: Obx(
                                      () => previousSearchController.isLoading.value
                                          ? Shimmers.lastSearchProductShimmer()
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: previousSearchController
                                                  .previousSearchProduct!.products!.lastSearchedProducts!.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(AppImage.clockIcon),
                                                      height: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text(
                                                      previousSearchController.previousSearchProduct!.products!
                                                          .lastSearchedProducts![index].productName
                                                          .toString(),
                                                      style: GoogleFonts.plusJakartaSans(),
                                                    ),
                                                    /*     const Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Colors.grey,
                                              )*/
                                                  ],
                                                ).paddingOnly(bottom: 20);
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: SmallTitle(title: St.popularSearch.tr),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: SizedBox(
                                    child: Obx(
                                      () => previousSearchController.isLoading.value
                                          ? Shimmers.popularSearchProductShimmer()
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: previousSearchController.previousSearchProduct!.products!
                                                  .popularSearchedProducts!.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      productId = previousSearchController.previousSearchProduct!
                                                          .products!.popularSearchedProducts![index].id!;
                                                      Get.toNamed("/ProductDetail");
                                                    },
                                                    child: SizedBox(
                                                      height: Get.height / 11,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            width: Get.width / 5.5,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage(previousSearchController
                                                                        .previousSearchProduct!
                                                                        .products!
                                                                        .popularSearchedProducts![index]
                                                                        .mainImage
                                                                        .toString()),
                                                                    fit: BoxFit.cover),
                                                                borderRadius: BorderRadius.circular(15)),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 15),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                SizedBox(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        previousSearchController
                                                                            .previousSearchProduct!
                                                                            .products!
                                                                            .popularSearchedProducts![index]
                                                                            .productName
                                                                            .toString(),
                                                                        style: GoogleFonts.plusJakartaSans(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(top: 7),
                                                                        child: Text(
                                                                          "${previousSearchController.previousSearchProduct!.products!.popularSearchedProducts![index].searchCount} ${St.searches.tr}",
                                                                          style: GoogleFonts.plusJakartaSans(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w300),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
