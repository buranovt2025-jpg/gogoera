import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/GetxController/user/new_collection_controller.dart';
import 'package:era_shop/Controller/GetxController/user/get_live_seller_list_controller.dart';
import 'package:era_shop/Controller/GetxController/user/just_for_you_prroduct_controller.dart';
import 'package:era_shop/View/MyApp/AppPages/bottom_tab_bar.dart';
import 'package:era_shop/View/MyApp/Seller/LiveSelling/fake_live_selling.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../../../Controller/GetxController/socket controller/user_get_selected_product_controller.dart';
import '../../../Controller/GetxController/user/get_reels_controller.dart';
import '../../Zego/ZegoUtils/permission.dart';
import '../../Zego/create_engine.dart';
import '../jump_to_live.dart';

class HomePageNewCollection extends StatefulWidget {
  const HomePageNewCollection({Key? key}) : super(key: key);

  @override
  State<HomePageNewCollection> createState() => _HomePageNewCollectionState();
}

class _HomePageNewCollectionState extends State<HomePageNewCollection> {
  NewCollectionController newCollectionController =
      Get.put(NewCollectionController());

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    // createEngine();
    requestPermission();
    newCollectionController.getNewCollectionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GeneralTitle(title: St.newCollection.tr),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
              height: 225,
              child: GetBuilder<NewCollectionController>(
                  builder: (NewCollectionController controller) {
                final productsList = controller.getNewCollection?.products ?? [];
                return Obx(
                  () => controller.isLoading.value
                      ? Shimmers.listViewProductHorizontal()
                      : ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.only(left: 18),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: productsList.length,
                          itemBuilder: (context, index) {
                            var products = productsList[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  productId = "${products.id}";
                                  Get.toNamed("/ProductDetail")!.then((value) =>
                                      controller.getNewCollectionData());
                                },
                                child: SizedBox(
                                  width: 152,
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              height: 178,
                                              width: double.maxFinite,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  products.mainImage.toString(),
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CupertinoActivityIndicator(
                                                animating: true,
                                              )),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Center(
                                                      child: Icon(Icons.error)),
                                            ),
                                          ),
                                          Text(
                                            products.productName.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "\$${products.price}",
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              /*log("Product ID ${getNewCollectionController.catalogItems[index].id}");
                                                  log("Category  ID ${getNewCollectionController.catalogItems[index].category}");*/

                                              controller.likeDislike(index);

                                              controller.postFavoriteData(
                                                  productId: "${products.id}",
                                                  categoryId:
                                                      "${products.category}");
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                color: MyColors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image(
                                                  image: products.isFavorite ==
                                                          true &
                                                              controller
                                                                  .likes[index]
                                                      ? AssetImage(
                                                          AppImage.productLike)
                                                      : AssetImage(AppImage
                                                          .productDislike),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                );
              })),
        ),
      ],
    );
  }
}

homePageAppBar() {
  return SizedBox(
    height: 56,
    width: double.maxFinite,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.offAll(BottomTabBar(
                index: 4,
              ));
              // BottomTabBar(index: 4);
              // Get.to(BottomTabBar(index: 4));
            },
            child: SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    child: imageXFile == null
                        ? CircleAvatar(
                            radius: 20,
                            // backgroundImage:-
                            //     AssetImage("assets/Home_page_image/profile.png"),
                            backgroundImage: NetworkImage(editImage),
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundImage: FileImage(File(imageXFile!.path)),
                          ),
                  ),
                  // CircleAvatar(
                  //     radius: 20, backgroundImage: NetworkImage(editImage)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width / 1.8,
                          child:
                              GeneralTitle(title: "${St.hi.tr},$editFirstName"),
                        ),
                        Text(
                          St.howAreYou.tr,
                          style: GoogleFonts.plusJakartaSans(
                              color: MyColors.darkGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/Notifications");
                    // Get.toNamed("/ChatPage");
                  },
                  child: Obx(
                    () => Image(
                      image: isDark.value
                          ? AssetImage(AppImage.notificationWhite)
                          : AssetImage(AppImage.notificationBlack),
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class HomePageLiveSelling extends StatefulWidget {
  const HomePageLiveSelling({super.key});

  @override
  State<HomePageLiveSelling> createState() => _HomePageLiveSellingState();
}

class _HomePageLiveSellingState extends State<HomePageLiveSelling> {
  ScrollController scrollController = ScrollController();
  GetLiveSellerListController getLiveSellerListController =
      Get.put(GetLiveSellerListController());
  UserGetSelectedProductController userGetSelectedProductController =
      Get.put(UserGetSelectedProductController());

  @override
  void initState() {
    scrollController.addListener(() {
      _scrollListener();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLiveSellerListController.getSellerList();
    });
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {});
      getLiveSellerListController.loadMoreData();
    }
  }

  @override
  void dispose() {
    getLiveSellerListController.getSellerLiveList.clear();
    getLiveSellerListController.start = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GeneralTitle(title: St.liveSelling.tr),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: SizedBox(
            height: Get.height / 10,
            width: Get.width,
            child: Obx(
              () => getLiveSellerListController.isLoading.value
                  ? Shimmers.liveSellerShow()
                  : getLiveSellerListController.getSellerLiveList.isEmpty
                      ? Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: isDark.value
                                  ? MyColors.lightBlack
                                  : MyColors.dullWhite,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                            "No live seller available",
                            style: TextStyle(
                              fontSize: 15,
                              color: isDark.value
                                  ? MyColors.darkGrey
                                  : MyColors.mediumGrey,
                            ),
                          )),
                        ).paddingSymmetric(horizontal: 15, vertical: 6)
                      : GetBuilder(
                          builder: (GetLiveSellerListController
                                  getLiveSellerListController) =>
                              ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: getLiveSellerListController
                                .getSellerLiveList.length,
                            padding: const EdgeInsets.only(left: 20),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: Get.width / 23),
                                child: SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: GestureDetector(
                                    onTap: () {
                                      var liveSellerList =
                                          getLiveSellerListController
                                              .getSellerLiveList[index];
                                      userGetSelectedProductController
                                          .getSelectedProducts(
                                              roomId:
                                                  "${liveSellerList.liveSellingHistoryId}");
                                      getLiveSellerListController
                                                  .getSellerLiveList[index]
                                                  .isFake ==
                                              true
                                          ? Get.to(() => FakeLiveSelling(
                                                videoUrl:
                                                    getLiveSellerListController
                                                        .getSellerLiveList[
                                                            index]
                                                        .video,
                                                image:
                                                    getLiveSellerListController
                                                        .getSellerLiveList[
                                                            index]
                                                        .image,
                                                businessName:
                                                    getLiveSellerListController
                                                        .getSellerLiveList[
                                                            index]
                                                        .businessName,
                                                name: getLiveSellerListController
                                                        .getSellerLiveList[
                                                            index]
                                                        .firstName! +
                                                    getLiveSellerListController
                                                        .getSellerLiveList[
                                                            index]
                                                        .lastName
                                                        .toString(),
                                                view:
                                                    getLiveSellerListController
                                                        .getSellerLiveList[
                                                            index]
                                                        .view
                                                        .toString(),
                                              ))
                                          : jumpToLivePage(
                                              context,
                                              roomID:
                                                  "${liveSellerList.liveSellingHistoryId}",
                                              isHost: false,
                                              localUserID: userId,
                                              localUserName: editFirstName,
                                            );
                                    },
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: getLiveSellerListController
                                              .getSellerLiveList[index].image
                                              .toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fitWidth,
                                              ),
                                              border: Border.all(
                                                  color: MyColors.primaryPink),
                                              color: MyColors.dullWhite,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CupertinoActivityIndicator(
                                              radius: 8,
                                              animating: true,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                  child: Icon(Icons.error)),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: 14,
                                            width: 14,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: MyColors.primaryGreen),
                                          ).paddingOnly(bottom: 12, right: 2),
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
        ),
      ],
    );
  }
}

class HomepageJustForYou extends StatefulWidget {
  final bool isShowTitle;
  const HomepageJustForYou({Key? key, required this.isShowTitle})
      : super(key: key);

  @override
  State<HomepageJustForYou> createState() => _HomepageJustForYouState();
}

class _HomepageJustForYouState extends State<HomepageJustForYou> {
  JustForYouProductController justForYouProductController =
      Get.put(JustForYouProductController());

  @override
  void initState() {
    super.initState();
    justForYouProductController.getJustForYouProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isShowTitle == true
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: GeneralTitle(title: St.justForYou.tr),
              )
            : const SizedBox.shrink(),
        Obx(
          () {
            final justForYouList = justForYouProductController
                .justForYouProduct?.justForYouProducts ?? [];
            return SizedBox(
            child: justForYouProductController.isLoading.value
                ? Shimmers.justForYouProductsShimmer()
                    .paddingSymmetric(vertical: 8, horizontal: 15)
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: justForYouList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var products = justForYouList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            productId = "${products.id}";
                            Get.toNamed("/ProductDetail")!.then((value) =>
                                justForYouProductController
                                    .getJustForYouProduct());
                          },
                          child: SizedBox(
                            height: Get.height / 8.2,
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    height: Get.height / 8.2,
                                    width: Get.width / 4.3,
                                    fit: BoxFit.cover,
                                    imageUrl: products.mainImage.toString(),
                                    placeholder: (context, url) => const Center(
                                        child: CupertinoActivityIndicator(
                                      animating: true,
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${products.productName.toString().capitalizeFirst}",
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Image(
                                                color: isDark.value
                                                    ? MyColors.white
                                                    : MyColors.black,
                                                image:
                                                    AssetImage(AppImage.cart),
                                                height: 15,
                                              ).paddingOnly(right: 7),
                                              Text(
                                                "${products.sold} Sold",
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        color: isDark.value
                                                            ? MyColors.white
                                                            : const Color(
                                                                0xff434E58),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13),
                                              ),
                                            ],
                                          ).paddingOnly(left: 15)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Size  ${products.attributes![0].value!.join(", ")}",
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      fontWeight:
                                                          FontWeight.w300),
                                            ).paddingOnly(top: 5, bottom: 17),
                                          ),
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Color(0xffFACC15),
                                            size: 23,
                                          ).paddingOnly(left: 40),
                                          Text(
                                            "${products.rating}",
                                            style: GoogleFonts.plusJakartaSans(
                                                color: isDark.value
                                                    ? MyColors.white
                                                    : const Color(0xff434E58),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "\$${products.price}",
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ).paddingOnly(left: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            );
          },
        )
      ],
    );
  }
}

class HomePageShorts extends StatefulWidget {
  const HomePageShorts({super.key});

  @override
  State<HomePageShorts> createState() => _HomePageShortsState();
}

class _HomePageShortsState extends State<HomePageShorts> {
  GetReelsForUserController getReelsForUserController =
      Get.put(GetReelsForUserController(), permanent: true);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    getReelsForUserController.start = 1;
    scrollController.addListener(() {
      _scrollListener();
    });
    getReelsForUserController.allReels.clear();
    getReelsForUserController.getAllReels();
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {});
      getReelsForUserController.reelsPagination();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getReelsForUserController.start = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: GeneralTitle(title: St.shorts.tr),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: 268,
            child: Stack(
              children: [
                Obx(
                  () => getReelsForUserController.isLoading.value
                      ? Shimmers.listViewShortHomePage()
                      : GetBuilder<GetReelsForUserController>(
                          builder: (GetReelsForUserController controller) {
                          return ListView.builder(
                            padding: const EdgeInsets.only(left: 18),
                            scrollDirection: Axis.horizontal,
                            cacheExtent: 1000,
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                getReelsForUserController.allReels.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  getReelsForUserController.pageController =
                                      PageController(initialPage: index);
                                  Get.offAll(() => BottomTabBar(
                                        index: 2,
                                      ));
                                },
                                child: SizedBox(
                                  height: 268,
                                  width: 172,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: 268,
                                          width: 172,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${getReelsForUserController.allReels[index].thumbnail}",
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CupertinoActivityIndicator(
                                            animating: true,
                                          )),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                  child: Icon(Icons.error)),
                                        ),
                                      ),
                                      // ClipRRect(
                                      //   // add here cachednetwork
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   child: Image.network(
                                      //     "${getReelsForUserController.allReels[index].thumbnail}",
                                      //     height: 268,
                                      //     width: 172,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.transparent,
                                              Colors.transparent,
                                              MyColors.black.withOpacity(0.60),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "${getReelsForUserController.allReels[index].productId!.description}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: MyColors.white,
                                          ),
                                        ),
                                      ).paddingSymmetric(
                                          vertical: 6, horizontal: 8),
                                    ],
                                  ),
                                ).paddingOnly(right: 11),
                              );
                            },
                          );
                        }),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => getReelsForUserController.moreLoading.value
                          ? Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.60)),
                              child: const Center(
                                child: SizedBox(
                                  height: 18,
                                  width: 18,
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
      ],
    );
  }

  // Future<String?> generateVideoThumbnail(String videoUrl) async {
  //   try {
  //     return await VideoThumbnail.thumbnailFile(
  //         video: videoUrl,
  //         thumbnailPath: (await getTemporaryDirectory()).path,
  //         imageFormat: ImageFormat.JPEG,
  //         maxHeight: 500,
  //         maxWidth: 220,
  //         quality: 100);
  //   } catch (e) {
  //     print("Error generating thumbnail: $e");
  //     return ''; // Return an empty string or a default thumbnail path
  //   }
  // }
}
