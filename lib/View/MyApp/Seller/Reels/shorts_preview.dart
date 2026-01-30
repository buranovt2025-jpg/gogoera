import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/app_circular.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../Controller/GetxController/seller/manage_reels_controller.dart';
import '../../../../utiles/Theme/my_colors.dart';

class ShortsPreview extends StatefulWidget {
  final String? videoUrl;

  /// For uploaded shorts
  final bool? ifUploadedReel;
  final String? productName;
  final String? productPrice;
  final String? productImage;
  final String? productDescription;
  final List<dynamic>? attributesArray;

  const ShortsPreview(
      {super.key,
      this.videoUrl,
      this.ifUploadedReel,
      this.productName,
      this.productPrice,
      this.productImage,
      this.productDescription,
      this.attributesArray});

  @override
  State<ShortsPreview> createState() => _ShortsPreviewState();
}

class _ShortsPreviewState extends State<ShortsPreview> {
  ManageShortsController manageShortsController = Get.put(ManageShortsController());
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoController = widget.ifUploadedReel == true
        ? VideoPlayerController.network("${widget.videoUrl}")
        : VideoPlayerController.file(manageShortsController.reelVideo!);

    await _videoController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      aspectRatio: Get.width / Get.height,
      showControls: false,
      autoPlay: true,
      autoInitialize: true,
      looping: true,
    );

    setState(() {
      _isInitialized = true;
    });
  }

  void _disposeVideoPlayer() {
    if (_isInitialized) {
      _videoController.dispose();
      _chewieController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey,
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Chewie(controller: _chewieController),
                Container(
                  decoration: BoxDecoration(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: MyColors.black.withOpacity(0.20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: MyColors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        widget.ifUploadedReel == true
                            ? const SizedBox.shrink()
                            : GestureDetector(
                                onTap: isDemoSeller == true
                                    ? () => displayToast(message: St.thisIsDemoApp.tr)
                                    : () {
                                        manageShortsController.uploadReels(widget.productDescription ?? "");
                                      },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: MyColors.primaryPink, borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                    child: Text(
                                      St.upload.tr,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 13, color: MyColors.white, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ).paddingSymmetric(vertical: 50),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: BlurryContainer(
                        height: 120,
                        width: Get.width / 1.5,
                        blur: 4.5,
                        color: MyColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        // decoration: BoxDecoration(
                        //   color: MyColors.white.withOpacity(0.40),
                        //   borderRadius: BorderRadius.circular(12),
                        // ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: 96,
                                width: 90,
                                fit: BoxFit.cover,
                                imageUrl: widget.ifUploadedReel == true
                                    ? widget.productImage.toString()
                                    : manageShortsController.productImage.toString(),
                                placeholder: (context, url) => const Center(
                                    child: CupertinoActivityIndicator(
                                  animating: true,
                                )),
                                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                              ),
                            ).paddingOnly(left: 6),
                            // Container(
                            //   height: 96,
                            //   width: 90,
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //         image: NetworkImage(manageShortsController.productImage.toString()),
                            //         fit: BoxFit.cover),
                            //     color: MyColors.white,
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            // )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      widget.ifUploadedReel == true
                                          ? widget.productName.toString()
                                          : manageShortsController.selectProductName.text,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
                                  Text(
                                    "${St.size.tr} ${widget.ifUploadedReel == true ? widget.attributesArray![0]["value"].join(", ") : manageShortsController.attributesArray![0]["value"].join(", ")}",
                                    // "Size Change",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(fontSize: 13.2),
                                  ).paddingOnly(top: 6),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${widget.ifUploadedReel == true ? widget.productPrice : manageShortsController.productPrice}",
                                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          displayToast(message: St.thisIsOnlyPreview.tr);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: MyColors.primaryPink,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                              child: Text(
                                            St.buyNow.tr,
                                            style: GoogleFonts.plusJakartaSans(
                                                color: MyColors.white, fontSize: 11.5, fontWeight: FontWeight.w600),
                                          )),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ).paddingSymmetric(vertical: 13, horizontal: 12),
                            )
                          ],
                        ),
                      ).paddingOnly(bottom: 15),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 43,
                          width: 43,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/Live_page_image/bgImage.jpg"), fit: BoxFit.cover)),
                        ).paddingOnly(right: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  editBusinessName,
                                  style: GoogleFonts.plusJakartaSans(
                                      color: MyColors.white, fontSize: 14.5, fontWeight: FontWeight.w600),
                                ).paddingOnly(bottom: 4, right: 7),
                                Image.asset(
                                  "assets/profile_icons/seller done.png",
                                  height: 18,
                                )
                              ],
                            ),
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  if (manageShortsController.isTextExpanded.value) {
                                    manageShortsController.isTextExpanded(false);
                                  } else {
                                    manageShortsController.isTextExpanded(true);
                                  }
                                },
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 900),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: SizedBox(
                                    width: Get.width * 0.6,
                                    height: manageShortsController.isTextExpanded.value ? Get.height * 0.16 : 43,
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Text(
                                        widget.ifUploadedReel == true
                                            ? widget.productDescription.toString()
                                            : manageShortsController.selectedProductDescription.text,
                                        maxLines: manageShortsController.isTextExpanded.value ? null : 2,
                                        overflow: manageShortsController.isTextExpanded.value
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: MyColors.white,
                                          height: 1.4,
                                          fontSize: 12.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ).paddingOnly(bottom: 23)
                  ],
                ).paddingSymmetric(horizontal: 14),
              ],
            ),
          ),
        ),
        Obx(
          () => manageShortsController.isLoading.value ? ScreenCircular.blackScreenCircular() : const SizedBox.shrink(),
        )
      ],
    );
  }
}
