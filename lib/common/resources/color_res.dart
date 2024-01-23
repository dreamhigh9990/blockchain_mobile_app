import 'package:flutter/material.dart';

class ColorRes {
  ColorRes._init();

  // static const kPrimaryColor = Color(0xFF9C9E4B);
  static const kPrimaryColor = Color(0xff9456b35);
  static const kSecondaryColor = Color(0xFF456B35);

  static const kBlackColor = Color(0xFF11240A);
  static const kWhiteColor = Color(0xFFFDFEE9);
  static const kLimeColor = Color(0xFFFDFEE9);

  // static const kStatusBar = Color(0xFF8E903D);
  static const kStatusBar = Color(0xFF456B35);
  static const kButtonBG = Color(0xff6B959F);
  static const gradientbutton = LinearGradient(
    colors: [
      Color(0xFF9963B7),
      Color(0xFF4710E4)
    ], // Define your gradient colors
    begin: Alignment.topLeft, // Define the gradient start point
    end: Alignment.bottomRight, // Define the gradient end point
  );
}
