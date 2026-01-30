import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Theme/my_colors.dart';

Widget noDataFound({
  required String image,
  required String text,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 140).paddingOnly(bottom: 20),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MyColors.primaryPink),
        ),
      ],
    ),
  );
}
