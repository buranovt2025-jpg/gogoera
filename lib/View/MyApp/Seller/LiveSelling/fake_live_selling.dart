import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../utiles/CoustomWidget/Page_devided/home_page_divided.dart';
import '../../../../utiles/Theme/my_colors.dart';
import '../../../../utiles/all_images.dart';
import '../../../../utiles/globle_veriables.dart';

class FakeLiveSelling extends StatefulWidget {
  final String? videoUrl;
  final String? image;
  final String? name;
  final String? businessName;
  final String? view;

  const FakeLiveSelling({Key? key, this.videoUrl, this.image, this.name, this.businessName, this.view})
      : super(key: key);

  @override
  State<FakeLiveSelling> createState() => _FakeLiveSellingState();
}

class _FakeLiveSellingState extends State<FakeLiveSelling> {
  bool isLiked = false;

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse("${widget.videoUrl}"));
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.play();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Stack(
                    children: [
                      CachedNetworkImage(
                        height: Get.height,
                        width: Get.width,
                        fit: BoxFit.cover,
                        imageUrl: "${widget.image}",
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                      ),
                      BlurryContainer(
                        height: Get.height,
                        width: Get.width,
                        color: MyColors.black.withOpacity(0.60),
                        blur: 4, child: const SizedBox(),
                        // decoration: BoxDecoration(color: MyColors.black.withOpacity(0.80)),
                      ),
                      const Center(child: CircularProgressIndicator())
                    ],
                  );
                }
              },
            ),
            Column(
              children: [
                SizedBox(
                  height: Get.height / 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(widget.image.toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.name}",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: MyColors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${widget.businessName}",
                                    style: GoogleFonts.plusJakartaSans(
                                      color: MyColors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlurryContainer(
                        height: 38,
                        width: Get.width / 2.8,
                        blur: 4.5,
                        color: MyColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                        // decoration: BoxDecoration(
                        //     color: Colors.grey.withOpacity(0.50),
                        //     borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                              image: AssetImage(AppImage.eyeImage),
                              height: 15.5,
                            ),
                            Text(
                              "${widget.view}k",
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.5, fontWeight: FontWeight.bold, color: MyColors.white),
                            ),
                            Container(
                              height: 26,
                              width: Get.width / 8,
                              decoration: BoxDecoration(
                                  color: MyColors.primaryRed, borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  St.liveText.tr,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13, fontWeight: FontWeight.w500, color: MyColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: BlurryContainer(
                          height: 38,
                          width: 38,
                          blur: 4.5,
                          color: MyColors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                          // decoration: BoxDecoration(
                          //     color: Colors.grey.withOpacity(0.50),
                          //     borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Icon(
                            Icons.close,
                            color: MyColors.white,
                            size: 14,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    barrierColor: Colors.transparent,
                                    isScrollControlled: true,
                                    Container(
                                      height: Get.height / 1.5,
                                      decoration: BoxDecoration(
                                          color: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(25))),
                                      child: Stack(
                                        children: [
                                          const SingleChildScrollView(
                                                  physics: BouncingScrollPhysics(),
                                                  child: HomepageJustForYou(isShowTitle: false))
                                              .paddingOnly(top: 60),
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                              height: 62,
                                              decoration: BoxDecoration(
                                                  color: isDark.value
                                                      ? MyColors.blackBackground
                                                      : const Color(0xffffffff),
                                                  borderRadius:
                                                      const BorderRadius.vertical(top: Radius.circular(10))),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                        SmallTitle(title: St.liveSelling.tr),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 5),
                                                        child: Obx(
                                                          () => Image(
                                                            image: isDark.value
                                                                ? AssetImage(AppImage.lightcart)
                                                                : AssetImage(AppImage.darkcart),
                                                            height: 22,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ).paddingOnly(top: 18, bottom: 6),
                                                  Obx(
                                                    () => Divider(
                                                      color: isDark.value ? MyColors.white : MyColors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ).paddingSymmetric(horizontal: 12),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: BlurryContainer(
                                  height: 49,
                                  width: 49,
                                  blur: 4.5,
                                  color: MyColors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Image(image: AssetImage(AppImage.redCart)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 49,
                                width: Get.width / 1.7,
                                child: TextFormField(
                                  maxLines: null,
                                  // style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                                  decoration: InputDecoration(
                                      filled: true,
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Image(image: AssetImage(AppImage.sendMessage)),
                                      ),
                                      hintText: St.writeHere.tr,
                                      fillColor: const Color(0xffF6F8FE),
                                      hintStyle: const TextStyle(color: Color(0xff9CA4AB), fontSize: 13),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(30)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: MyColors.primaryPink),
                                          borderRadius: BorderRadius.circular(30))),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  isLiked = !isLiked;
                                },
                                child: Container(
                                  height: 49,
                                  width: 49,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffF6F8FE),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13),
                                    child: Image(
                                      image: isLiked
                                          ? AssetImage(AppImage.productDislike)
                                          : AssetImage(AppImage.productLike),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List justForYouImage = [
    "assets/Home_page_image/just_for_you/Rectangle 22431.png",
    "assets/Home_page_image/just_for_you/Rectangle 22431 (1).png",
    "assets/Home_page_image/just_for_you/Rectangle 22431 (2).png",
    "assets/Home_page_image/just_for_you/Group 1000003097.png",
    "assets/Home_page_image/just_for_you/Rectangle 22431.png",
  ];
  List justForYouName = [
    "Kendow Premium T-shirt",
    "Bondera Premium T-shirt",
    "Degra Premium T-shirt",
    "Dress Rehia",
    "Kendow Premium T-shirt",
  ];
  List justForYouPrise = [
    "95",
    "95",
    "89",
    "85",
    "95",
  ];
}
