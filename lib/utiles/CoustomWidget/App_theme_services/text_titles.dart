import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralTitle extends StatelessWidget {
  final String title;
  const GeneralTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.plusJakartaSans(
          fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class SmallTitle extends StatelessWidget {
  final String title;
  const SmallTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
          fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
