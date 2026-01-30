import 'dart:developer';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:get/get.dart';
import '../../../ApiModel/user/CreateRatingModel.dart';
import '../../../ApiService/user/create_rating_service.dart';
import '../../../utiles/globle_veriables.dart';

class CreateRatingController extends GetxController {
  CreateRatingModel? createRating;
  RxBool isLoading = false.obs;

  RxDouble rating = 4.0.obs;

  postRatingData() async {
    try {
      log("Rating  value :: $rating");
      isLoading(true);
      var data = await CreateRatingService().createRating(userId: userId, productId: productId, rating: rating);
      createRating = data;
      if (createRating!.status == true) {
        displayToast(message: "Your review submitted \nsuccessfully");
      } else {
        displayToast(message: "You have already given review \non this product!!");
      }
    } finally {
      isLoading(false);
      log('Review Api Response');
    }
  }
}
