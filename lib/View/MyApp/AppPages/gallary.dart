import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/GetxController/user/new_collection_controller.dart';
import 'package:era_shop/Controller/GetxController/user/gallery_catagory_controller.dart';
import 'package:era_shop/Controller/GetxController/user/get_all_category_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/CoustomWidget/Page_devided/home_page_divided.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:google_fonts/google_fonts.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with SingleTickerProviderStateMixin {
  GalleryCategoryController galleryCategoryController = Get.put(GalleryCategoryController());
  GetAllCategoryController getAllCategoryController = Get.put(GetAllCategoryController());
  NewCollectionController addToFavoriteController = Get.put(NewCollectionController());

  //------------------------------------------------------------------------

  final List<bool> _likes = List.generate(100000, (_) => true);
  ScrollController scrollController = ScrollController();
  TabController? tabController;

  bool isApiCalling = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      _scrollListener();
    });
    final _tabChangeDebouncer = Debouncer(delay: Duration(milliseconds: 500));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log("callll 1");
      await getAllCategoryController.getCategory().then((value) => tabBarLength()).then((value) => _handleTabChange());

      tabController!.addListener(() async {
        print("*************** ${tabController?.index}");
        print("***************isApiCalling ${isApiCalling}");
        galleryCategoryController.galleryProducts.clear();
        //  if (isApiCalling) {
        //   galleryCategoryController.galleryProducts.clear();
        // }
        _tabChangeDebouncer.call(() {
          _handleTabChange();
        });
      });
    });
  }

  void tabBarLength() {
    tabController = TabController(length: getAllCategoryController.getAllCategory!.category!.length, vsync: this);
  }

  // Future _handleTabChange() async {
  //   log("callll 3");
  //   int selectedIndex = tabController!.index;
  //   String selectedCategory = getAllCategoryController.getAllCategory!.category![selectedIndex].id.toString();
  //   isApiCalling = false;
  //   await galleryCategoryController.getCategoryData(selectCategory: selectedCategory);
  //   isApiCalling = true;
  // }
  Future _handleTabChange() async {
    log("callll 3");
    int selectedIndex = tabController!.index;
    String selectedCategory = getAllCategoryController.getAllCategory!.category![selectedIndex].id.toString();
    // Store the latest selected tab index
    // int latestSelectedIndex = selectedIndex;
    print("***************selectedIndex ${selectedIndex}");
    print("***************tabController!.index ${tabController!.index}");

    // Check if the current tab index matches the latest selected tab index
    if (selectedIndex == tabController!.index) {
      galleryCategoryController.isLoading(true);
      await galleryCategoryController.getCategoryData(selectCategory: selectedCategory);
    }
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        tabController!.indexIsChanging) {
      setState(() {
        int selectedIndex = tabController!.index;
        String selectedCategory = getAllCategoryController.getAllCategory!.category![selectedIndex].id.toString();
        galleryCategoryController.loadMoreData(selectCategory: selectedCategory);
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Obx(
          () => getAllCategoryController.isLoading.value
              ? Shimmers.productGridviewShimmer().paddingSymmetric(vertical: 15, horizontal: 15)
              : NestedScrollView(
                  physics: const BouncingScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 250,
                        pinned: true,
                        floating: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/SearchPage");
                                  },
                                  child: dummySearchField(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: Get.height / 40),
                                child: const HomePageLiveSelling(),
                              ),
                              // galleryFlashSale(),
                            ],
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(55),
                          child: Container(
                            height: 52,
                            color: isDark.value ? MyColors.blackBackground : MyColors.white,
                            width: Get.width,
                            child: TabBar(
                              controller: tabController,
                              physics: const BouncingScrollPhysics(),
                              onTap: (value) {
                                log("message::::value:::$value");
                                galleryCategoryController.galleryProducts.clear();
                                galleryCategoryController.isLoading(true);
                              },
                              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                              indicator: BoxDecoration(
                                color: MyColors.primaryPink,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              // onTap: (value) {},
                              isScrollable:
                                  getAllCategoryController.getAllCategory!.category!.length > 4 ? true : false,
                              unselectedLabelColor: isDark.value ? MyColors.white : MyColors.black,
                              unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                                color: MyColors.white,
                              ),
                              tabs: getAllCategoryController.getAllCategory!.category!.map<Tab>((category) {
                                return Tab(
                                  text: category.name.toString().capitalizeFirst,
                                );
                              }).toList(),
                            ).paddingSymmetric(vertical: 5),
                          ),
                        ),
                      )
                    ];
                  },
                  body: GetBuilder<GalleryCategoryController>(
                    builder: (GalleryCategoryController galleryCategoryController) => Obx(
                      () => galleryCategoryController.isLoading.value
                          ? Shimmers.productGridviewShimmer().paddingSymmetric(vertical: 15, horizontal: 15)
                          : TabBarView(
                              physics: const BouncingScrollPhysics(),
                              controller: tabController,
                              children: getAllCategoryController.getAllCategory!.category!.map((category) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                  child: Stack(
                                    children: [
                                      galleryCategoryController.galleryProducts.isEmpty
                                          ? noDataFound(
                                              image: "assets/no_data_found/closebox.png",
                                              text: St.thisCategoryIsEmpty.tr)
                                          : GridView.builder(
                                              physics: const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: galleryCategoryController.galleryProducts.length,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 15,
                                                crossAxisCount: 2,
                                                mainAxisExtent: 49.2 * 5,
                                              ),
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    productId = galleryCategoryController.galleryProducts[index].id!;
                                                    Get.toNamed("/ProductDetail");
                                                  },
                                                  child: SizedBox(
                                                    height: 150,
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
                                                                imageUrl: galleryCategoryController
                                                                    .galleryProducts[index].mainImage
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
                                                                "${galleryCategoryController.galleryProducts[index].productName}",
                                                                overflow: TextOverflow.ellipsis,
                                                                style: GoogleFonts.plusJakartaSans(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 7),
                                                              child: Text(
                                                                "\$${galleryCategoryController.galleryProducts[index].price}",
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
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _likes[index] = !_likes[index];
                                                                });

                                                                addToFavoriteController.postFavoriteData(
                                                                    productId:
                                                                        "${galleryCategoryController.galleryProducts[index].id}",
                                                                    categoryId:
                                                                        "${galleryCategoryController.galleryProducts[index].category!.id}");
                                                              },
                                                              child: Container(
                                                                height: 32,
                                                                width: 32,
                                                                decoration: BoxDecoration(
                                                                  color: MyColors.white,
                                                                  shape: BoxShape.circle,
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Image(
                                                                    image:
                                                                        // galleryCategoryController.galleryCategory!.product![index].isFavorite
                                                                        galleryCategoryController.galleryProducts[index]
                                                                                    .isFavorite ==
                                                                                true & _likes[index]
                                                                            ? AssetImage(AppImage.productLike)
                                                                            : AssetImage(AppImage.productDislike),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Obx(
                                            () => galleryCategoryController.moreLoading.value
                                                ? Container(
                                                    height: 55,
                                                    width: 55,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle, color: Colors.black.withOpacity(0.40)),
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
                                );
                              }).toList(),
                            ),
                    ),
                  ),
                ),
        ),
      ),
    ));
  }
}
