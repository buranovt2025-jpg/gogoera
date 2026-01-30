 import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonSignInButton extends StatelessWidget {
  final void Function() onTaped;
  final String text;
  const CommonSignInButton({
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
            color: MyColors.primaryPink,
            borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
                color: MyColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
