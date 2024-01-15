import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Rubik',
  canvasColor: const Color(0x1fff1c1b),
  primaryColor: const Color(0xFF1A4080),
  primaryColorLight: const Color(0xff007ac9),
  secondaryHeaderColor: const Color(0xff007ac9),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF2C2C2C),
  cardColor: const Color(0xFF252525),
  hintColor: const Color(0xFFE7F6F8),
  focusColor: const Color(0xFFADC4C8),
  shadowColor: Colors.black.withOpacity(0.4),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  textTheme: const TextTheme(
    labelLarge: TextStyle(color: Color(0xFF252525)),
    displayLarge: TextStyle(fontWeight: FontWeight.w300, fontSize: Dimensions.fontSizeDefault),
    displayMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeSmall),
    displaySmall: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.fontSizeExtraSmall),
    headlineLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: Dimensions.fontSizeOverLarge),
    headlineMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.fontSizeLarge),
    headlineSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault),
    titleLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: Dimensions.fontSizeDefault),
    titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontWeight: FontWeight.w900, fontSize: Dimensions.fontSizeExtraSmall),
    bodyMedium: TextStyle(
      fontSize: Dimensions.fontSizeSmall,
    ),
    bodyLarge: TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w400, color: ColorResources.priceColor),
  ),
);
