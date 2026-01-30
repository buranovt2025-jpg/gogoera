import 'dart:convert';
import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:era_shop/View/MyApp/AppPages/reels_page/api/reels_like_dislike_api.dart';
import 'package:era_shop/View/MyApp/AppPages/reels_page/controller/reels_controller.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';

import '../../../../../ApiModel/seller/GetReelsForUserModel.dart';

class PreviewReelsView extends StatefulWidget {
  const PreviewReelsView({super.key, required this.index, required this.currentPageIndex});

  final int index;
  final int currentPageIndex;

  @override
  State<PreviewReelsView> createState() => _PreviewReelsViewState();
}

class _PreviewReelsViewState extends State<PreviewReelsView> with TickerProviderStateMixin {
  final controller = Get.find<ReelsController>();

  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  RxBool isPlaying = true.obs;
  RxBool isShowIcon = false.obs;

  RxBool isPreviewDetails = false.obs;

  RxBool isBuffering = false.obs;
  RxBool isVideoLoading = true.obs;

  RxBool isShowLikeAnimation = false.obs;
  RxBool isShowLikeIconAnimation = false.obs;

  RxBool isReelsPage = true.obs; // This is Use to Stop Auto Playing..

  RxBool isLike = false.obs;
  RxMap customChanges = {"like": 0, "comment": 0}.obs;

  AnimationController? _controller;
  late Animation<double> _animation;
  late AnimationController _likeAnimationController;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    _likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 185),
    );

    if (_controller != null) {
      _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    }
    initializeVideoPlayer();
    customSetting();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    onDisposeVideoPlayer();
    log("Dispose Method Called Success");
    super.dispose();
  }

  Future<void> initializeVideoPlayer() async {
    try {
      String videoPath = controller.mainReels[widget.index].video ?? "";

      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoPath));

      await videoPlayerController?.initialize();

      if (videoPlayerController != null && (videoPlayerController?.value.isInitialized ?? false)) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          looping: true,
          allowedScreenSleep: false,
          allowMuting: false,
          showControlsOnInitialize: false,
          showControls: false,
          maxScale: 1,
        );

        if (chewieController != null) {
          isVideoLoading.value = false;
          (widget.index == widget.currentPageIndex && isReelsPage.value)
              ? onPlayVideo()
              : null; // Use => First Time Video Playing...
        } else {
          isVideoLoading.value = true;
        }

        videoPlayerController?.addListener(
          () {
            // Use => If Video Buffering then show loading....
            (videoPlayerController?.value.isBuffering ?? false) ? isBuffering.value = true : isBuffering.value = false;

            if (isReelsPage.value == false) {
              onStopVideo(); // Use => On Change Routes...
            }
          },
        );
      }
    } catch (e) {
      onDisposeVideoPlayer();
      log("Reels Video Initialization Failed !!! ${widget.index} => $e");
    }
  }

  void onStopVideo() {
    isPlaying.value = false;
    videoPlayerController?.pause();
  }

  void onPlayVideo() {
    isPlaying.value = true;
    videoPlayerController?.play();
  }

  void onDisposeVideoPlayer() {
    try {
      onStopVideo();
      videoPlayerController?.dispose();
      chewieController?.dispose();
      chewieController = null;
      videoPlayerController = null;
      isVideoLoading.value = true;
    } catch (e) {
      log(">>>> On Dispose VideoPlayer Error => $e");
    }
  }

  void customSetting() {
    isLike.value = controller.mainReels[widget.index].isLike!;
    customChanges["like"] = int.parse(controller.mainReels[widget.index].like.toString());
  }

  void onClickVideo() async {
    if (isVideoLoading.value == false) {
      videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
      isShowIcon.value = true;
      await 2.seconds.delay();
      isShowIcon.value = false;
    }
    if (isReelsPage.value == false) {
      isReelsPage.value = true; // Use => On Back Reels Page...
    }
  }

  void onClickPlayPause() async {
    log("onClickPlayPause:::::::::");
    log("onClickPlayPause:::::::::");
    videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
    if (isReelsPage.value == false) {
      isReelsPage.value = true; // Use => On Back Reels Page...
    }
  }

  Future<void> onClickShare() async {
    var url = Uri.parse("https://play.google.com/store/apps/details?id=com.erashop.live");
    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
      throw "Cannot load the page";
    }
  }

  Future<void> onClickLike() async {
    log("onClickLike:::::::::");
    if (isLike.value) {
      isLike.value = false;
      customChanges["like"]--;
    } else {
      isLike.value = true;
      customChanges["like"]++;
    }

    isShowLikeIconAnimation.value = true;
    await 500.milliseconds.delay();
    isShowLikeIconAnimation.value = false;

    await ReelsLikeDislikeApi.callApi(
      loginUserId: userId,
      videoId: controller.mainReels[widget.index].id!,
    );
  }

  Future<void> onDoubleClick() async {
    log("onDoubleClick:::::::::");
    if (isLike.value) {
      log("onDoubleClick:isShowLikeAnimation::::::::");
      _likeAnimationController.forward();
      isShowLikeAnimation.value = true;

      await 1200.milliseconds.delay();
      isShowLikeAnimation.value = false;
    } else {
      isLike.value = true;
      customChanges["like"]++;
      _likeAnimationController.forward();
      isShowLikeAnimation.value = true;
      Vibration.vibrate(duration: 50, amplitude: 128);
      await 1200.milliseconds.delay();
      isShowLikeAnimation.value = false;
      await ReelsLikeDislikeApi.callApi(
        loginUserId: userId,
        videoId: controller.mainReels[widget.index].id!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Attributes>? _attributesArray = controller.mainReels[widget.index].productId!.attributes;

    final aattributeArray = jsonDecode(jsonEncode(_attributesArray));
    if (widget.index == widget.currentPageIndex) {
      // Use => Play Current Video On Scrolling...
      (isVideoLoading.value == false && isReelsPage.value) ? onPlayVideo() : null;
    } else {
      // Restart Previous Video On Scrolling...
      isVideoLoading.value == false ? videoPlayerController?.seekTo(Duration.zero) : null;
      onStopVideo(); // Stop Previous Video On Scrolling...
    }
    print("video url::::::::${controller.mainReels[widget.index].description ?? "not here"}");
    return Scaffold(
      body: Obx(
        () => isVideoLoading.value
            ? Shimmers.reelsView()
            : SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    GestureDetector(
                      child: Container(
                        color: Colors.black,
                        height: (Get.height - 60),
                        width: Get.width,
                        child: SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: videoPlayerController?.value.size.width ?? 0,
                              height: videoPlayerController?.value.size.height ?? 0,
                              child: Chewie(controller: chewieController!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => isShowIcon.value
                          ? Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: onClickPlayPause,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  padding: EdgeInsets.only(left: isPlaying.value ? 0 : 2),
                                  decoration:
                                      BoxDecoration(color: MyColors.black.withOpacity(0.3), shape: BoxShape.circle),
                                  child: Center(
                                      child: Icon(
                                    isPlaying.value ? Icons.pause : Icons.play_arrow,
                                    size: 30,
                                    color: MyColors.white,
                                  )
                                      //
                                      // Image.asset(
                                      //   isPlaying.value ? AppAsset.icPause : AppAsset.icPlay,
                                      //   width: 30,
                                      //   height: 30,
                                      //   color: AppColor.white,
                                      // ),
                                      ),
                                ),
                              ),
                            )
                          : const Offstage(),
                    ),
                    Obx(
                      () => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isShowLikeAnimation.value) ...{
                              AnimatedBuilder(
                                animation: _likeAnimationController,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _likeAnimationController.value,
                                    child: child,
                                  );
                                },
                                child: const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 100,
                                ),
                              ),
                            }
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: Get.height / 4,
                        width: Get.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 100),
                        height: Get.height,
                        child: Column(
                          children: [
                            const Spacer(),
                            Obx(
                              () => SizedBox(
                                height: 50,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: isShowLikeIconAnimation.value ? 15 : 50,
                                  width: isShowLikeIconAnimation.value ? 15 : 50,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: onClickLike,
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Image.asset("assets/icons/reels_favorite.png",
                                            color: isLike.value ? Colors.red : Colors.white, width: 32),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Text(
                                customChanges["like"].toString(),
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14, fontWeight: FontWeight.w700, color: MyColors.white),
                              ),
                            ),
                            const SizedBox(height: 25),
                            GestureDetector(
                              onTap: onClickShare,
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: Image.asset("assets/icons/reels_share.png", color: Colors.white, width: 32)),
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: 45,
                              child: RotationTransition(
                                  turns: _animation, child: Image.asset("assets/icons/reels_music.png")),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onClickVideo,
                      onDoubleTap: onDoubleClick,
                      child: Container(
                        color: MyColors.transparent,
                        height: Get.height,
                        width: Get.width / 1.25,
                        padding: const EdgeInsets.only(left: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlurryContainer(
                              height: 120,
                              width: Get.width / 1.47,
                              blur: 4.5,
                              color: MyColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              child: Row(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                    child: CachedNetworkImage(
                                      height: 96,
                                      width: 90,
                                      fit: BoxFit.cover,
                                      imageUrl: controller.mainReels[widget.index].productId?.mainImage ?? "",
                                      placeholder: (context, url) =>
                                          const Center(child: CupertinoActivityIndicator(animating: true)),
                                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(controller.mainReels[widget.index].productId?.productName ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
                                        Text(
                                          "${aattributeArray[0]["name"].toString().capitalizeFirst} ${aattributeArray[0]["value"].join(", ")}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(fontSize: 13.2),
                                        ).paddingOnly(top: 6),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${controller.mainReels[widget.index].productId?.price ?? 0}",
                                              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                productId = controller.mainReels[widget.index].productId?.id ?? "";
                                                Get.toNamed("/ProductDetail");
                                                videoPlayerController?.pause();
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    St.buyNow.tr,
                                                    style: GoogleFonts.plusJakartaSans(
                                                        color: MyColors.white,
                                                        fontSize: 11.5,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ).paddingSymmetric(vertical: 13, horizontal: 7),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 43,
                                  width: 43,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    height: 96,
                                    width: 90,
                                    fit: BoxFit.cover,
                                    imageUrl: controller.mainReels[widget.index].sellerId?.image ?? '',
                                    placeholder: (context, url) => const Center(
                                        child: CupertinoActivityIndicator(
                                      animating: true,
                                    )),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                  ),
                                ).paddingOnly(right: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          controller.mainReels[widget.index].sellerId?.businessName ?? "",
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
                                        onTap: () => isPreviewDetails.value = !isPreviewDetails.value,
                                        child: AnimatedSize(
                                          duration: const Duration(milliseconds: 900),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: SizedBox(
                                            width: Get.width * 0.6,
                                            height: isPreviewDetails.value ? Get.height * 0.16 : 43,
                                            child: SingleChildScrollView(
                                              physics: const BouncingScrollPhysics(),
                                              child: Text(
                                                controller.mainReels[widget.index].description ??
                                                    controller.mainReels[widget.index].productId?.description ??
                                                    '',
                                                maxLines: isPreviewDetails.value ? null : 2,
                                                overflow: isPreviewDetails.value
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
