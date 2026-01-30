import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInBackButton extends StatelessWidget {
  final void Function() onTaped;
  const SignInBackButton({
    super.key,
    required this.onTaped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTaped,
        child: Obx(
          () => Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: isDark.value
                  ? const Color(0xff282836)
                  : const Color(0xffeceded),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
            ),
          ),
        ));
  }
}
