import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';

ThemeData light = ThemeData(
  fontFamily: 'Rubik',
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xFF0B1B34),
  primaryColorLight: const Color(0xff007ac9),
  secondaryHeaderColor: const Color(0xff007ac9),
  brightness: Brightness.light,
  cardColor: Colors.white,
  focusColor: const Color(0xFFADC4C8),
  hintColor: const Color(0xFF52575C),
  shadowColor: Colors.grey[300],
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  drawerTheme: const DrawerThemeData(
    elevation: 12,
    scrimColor: Colors.transparent,
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(color: ColorResources.colorLightGray),
    displayLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.fontSizeDefault),
    displayMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeSmall),
    displaySmall: TextStyle(fontWeight: FontWeight.w300, fontSize: Dimensions.fontSizeExtraSmall),
    headlineLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: Dimensions.fontSizeOverLarge),
    headlineMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.fontSizeLarge),
    headlineSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault),
    titleLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: Dimensions.fontSizeLarge),
    titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontWeight: FontWeight.w900, fontSize: Dimensions.fontSizeDefault),
    bodyMedium: TextStyle(fontSize: Dimensions.fontSizeSmall),
    bodyLarge: TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w400, color: ColorResources.priceColor),
  ),
);
