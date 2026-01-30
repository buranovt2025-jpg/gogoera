import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryPinkButton extends StatelessWidget {
  final void Function() onTaped;
  final String text;
  const PrimaryPinkButton({
    super.key,
    required this.onTaped,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaped,
      child: Container(
        height: 58,
        decoration: BoxDecoration(color: MyColors.primaryPink, borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class PrimaryWhiteButton extends StatelessWidget {
  final void Function() onTaped;
  final String text;
  const PrimaryWhiteButton({
    super.key,
    required this.onTaped,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaped,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.primaryPink,
            ),
            borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
                color: MyColors.primaryPink, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class PrimaryShortWhiteButton extends StatelessWidget {
  final void Function() onTaped;
  final String text;
  const PrimaryShortWhiteButton({
    super.key,
    required this.onTaped,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaped,
      child: Container(
        height: 37,
        width: Get.width / 3.7,
        decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.primaryPink,
            ),
            borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
                color: MyColors.primaryPink, fontSize: 12.5, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class PrimaryRoundButton extends StatelessWidget {
  final void Function() onTaped;
  final icon;
  final iconColor;
  const PrimaryRoundButton({
    super.key,
    required this.onTaped,
    required this.icon,
     this.iconColor,
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
            color: isDark.value ? const Color(0xff282836) : const Color(0xffeceded),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 22,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final void Function() onTaped;
  final text;
  final double weights;
  final containerColor;
  final textColor;
  const FilterButton({
    super.key,
    required this.onTaped,
    required this.text,
    required this.weights,
    required this.containerColor,
    required this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaped,
      child: Obx(
        () => Container(
          height: 42,
          width: weights,
          decoration: BoxDecoration(
              border: Border.all(color: containerColor, width: 1),
              color: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(color: textColor, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingButton extends StatelessWidget {
  final void Function() onTaped;
  final double weights;
  final containerColor;
  final icons;
  const RatingButton({
    super.key,
    required this.onTaped,
    required this.weights,
    required this.containerColor,
    required this.icons,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaped,
      child: Container(
        height: 42,
        width: weights,
        decoration: BoxDecoration(
            border: Border.all(color: containerColor, width: 1),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50)),
        child: Center(child: icons),
      ),
    );
  }
}
