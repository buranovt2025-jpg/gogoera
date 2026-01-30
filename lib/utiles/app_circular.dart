import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenCircular {
  static Container blackScreenCircular() {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.black54,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
