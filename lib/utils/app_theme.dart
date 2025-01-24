import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color pageBg = Color.fromARGB(255, 250, 250, 250);
  static const Color colorGrey = Color(0xFFD5D5D5);
  static const Color colorGreyDark = Color(0xFF6C6C6C);
  static const Color colorGreyLight = Color(0xFFF2F2F2);
  static const Color colorGreyMedium = Color(0xFFB7B7B7);
  static const Color colorText = Color(0xFF595A5A);
  static const Color borderColor = Color(0xFFD5D5D5);
  static const Color boxColor = Color(0xFFD5D5D5);
  static const Color shimmerBaseColor = Color(0xFFF1F1F1);
  static const Color shimmerHighlightColor = Color(0xFFE0E0E0);
  static const Color shimmerChildColor = Color(0xFFF1F1F1);
  static const Color badgeColor = Color(0xFFEE4F0A);
  static const Color colorGreen = Color(0xFF3EC662);
  static const Color colorRed = Color(0xFFE10D0D);
  static const Color colorHorizontalLine = Color.fromARGB(255, 191, 191, 191);
  static const Color colorBrownButton = Color(0xFF917337);
  static const Color colorBlue = Color(0xFF2985DB);
  static const Color colorBlack = Color.fromARGB(255, 0, 0, 0);
  static const Color colorPrimary = Color(0xFF0E1724);

  static ThemeData theme = ThemeData(
    fontFamily: 'REGULAR',
    useMaterial3: false,
    dividerColor: Colors.transparent,
    dividerTheme: const DividerThemeData(color: colorGrey),
    expansionTileTheme: const ExpansionTileThemeData(
        textColor: AppTheme.black, iconColor: AppTheme.colorPrimary),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
