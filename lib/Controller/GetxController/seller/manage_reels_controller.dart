import 'dart:developer';
import 'dart:io';

import 'package:era_shop/Controller/GetxController/seller/show_uploaded_reels_controller.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../ApiService/seller/reel_delete_service.dart';
import '../../../ApiService/seller/upload_reels_service.dart';

class ManageShortsController extends GetxController {
  ShowUploadedShortsController showUploadedShortsController = Get.put(ShowUploadedShortsController());

  File? reelVideo;
  XFile? reelsXFiles;
  VideoPlayerController? videoPlayerController;
  final ImagePicker reelsPick = ImagePicker();

  String? productId;
  String? sellerId;
  RxBool isTextExpanded = false.obs;

  int? selectedIndex;
  List<dynamic>? attributesArray;
  String productImage = "";
  String? thumbnailPath;

  TextEditingController selectProductName = TextEditingController();
  TextEditingController selectedProductDescription = TextEditingController();
  String productPrice = "";

  RxBool isLoading = false.obs;
  RxBool deleteReelLoading = false.obs;

  reelsPickFromGallery() async {
    // reelsXFiles = await reelsPick.pickVideo(source: ImageSource.gallery);
    // reelVideo = File(reelsXFiles!.path);
    // videoPlayerController = VideoPlayerController.file(reelVideo!);
    // await videoPlayerController!.initialize();
    // update();

    reelsXFiles = await reelsPick.pickVideo(source: ImageSource.gallery);
    reelVideo = File(reelsXFiles!.path);

    thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: reelVideo!.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 360,
      maxHeight: 550,
      quality: 100,
    );

    log("Thumbnail path :: $thumbnailPath");

    videoPlayerController = VideoPlayerController.file(reelVideo!);
    await videoPlayerController!.initialize();

    update();
  }

  uploadReels(String description) async {
    try {
      isLoading(true);
      var data = await UploadReelsApi()
          .uploadReelApi(sellerId: sellerId!, productId: productId!, video: reelVideo!, thumbnailPath: "$thumbnailPath",description: description);
      if (data.status == true) {
        showUploadedShortsController.afterDeleteReels();
        displayToast(message: data.message.toString());
        Get.back();
        Get.back();
      } else {
        displayToast(message:data.message.toString());
      }
    } finally {
      isLoading(false);
    }
  }

  deleteReel({required String reelId}) async {
    try {
      deleteReelLoading(true);
      var data = await ReelDeleteService().deleteReel(reelId: reelId);
      Get.back();
      if (data!.status == true) {
        showUploadedShortsController.afterDeleteReels();
        displayToast(message: "Short deleted!");
      } else {
        displayToast(message: "Something went wrong!");
      }
    } finally {
      deleteReelLoading(false);
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}
