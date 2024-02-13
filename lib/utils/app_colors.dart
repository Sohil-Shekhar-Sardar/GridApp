import 'package:flutter/material.dart';

class ColorsForApp {
  static Color primaryColor = const Color(0xff24142c);
  static Color shadowColor = const Color(0xff6F6AF8).withOpacity(0.45);
  static Color blueShade6 = const Color(0xFF1066FF).withOpacity(0.06);
  static Color blueShade12 = const Color(0xFF1066FF).withOpacity(0.12);
  static Color blueBorderShade12 = const Color(0xFF413789).withOpacity(0.12);
  static Color blueShade22 = const Color(0xffCAD5FF).withOpacity(0.22);
  static Color selectedTabBackgroundColor = const Color(0xffD2E0FF);
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black.withOpacity(0.8);
  static Color redColor = Colors.red;
  static Color greenColor = Colors.green;
  static Color yellowColor = Colors.amber;
  static Color greyColor = Colors.grey;
  static Color grayScale500 = ColorConverter.hexToColor("#9E9E9E");
  static Color hintColor = ColorConverter.hexToColor("#9D9D9D");
  static Color secondaryColor = ColorConverter.hexToColor("#6C82BA");
  static Color shimmerBaseColor = Colors.grey[300]!;
  static Color shimmerHighlightColor = Colors.white;
}

class ColorConverter {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
