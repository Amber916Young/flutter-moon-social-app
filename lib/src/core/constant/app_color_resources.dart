import 'package:flutter/material.dart';
import 'package:moon/src/core/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorResources {
  static Color getSearchBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF585a5c) : searchBg;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF343636) : const Color(0xFFF4F7FC);
  }

  static Color getHintColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF98a1ab) : const Color(0xFF52575C);
  }

  static Color getHighlightColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF98a1ab) : colorNero;
  }

  static Color getGreyBunkerColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFE4E8EC) : const Color(0xFF25282B);
  }

  static Color getCartTitleColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF61699b) : const Color(0xFF000743);
  }

  static Color getProfileMenuHeaderColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? footerColor.withOpacity(0.5) : footerColor;
  }

  static Color getFooterColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF494949) : const Color(0xFFFFDDD9);
  }

  static const Color colorLightOrg = Color(0xFFFFECE1);
  static const Color colorLightGray = Color(0xFFD9D9D9);
  static const Color greyColorFA = Color(0xFFFAFAFA);
  static const Color searchBg = Color(0xFFF3F3F3);
  static const Color priceColor = Color(0xFFFF4A11);

  static const Color colorNero = Color(0xFF1F1F1F);
  static const Color colorGray = Color(0xFF585858);
  static const Color borderColor = Color(0xFFDCDCDC);
  static const Color footerColor = Color(0xFFFFDDD9);
  static const Color cardShadowColor = Color(0xFFA7A7A7);
  static const Color warnColor = Color(0xFFFF9800);
  static const Color amberColor = Color(0xFFEC9A3C);
  static const Color acceptedColor = Color(0xFF00C9DB);
  static const Color failColor = Color(0xFFED4C78);
  static const Color successColor = Color(0xFF00C9A7);
  static const Color refundColor = Color(0xFF7690FF);
  static const Color darkRefundColor = Color(0xFF00185E);

  static const Color couponColor = Color(0xFFF2E2D3);

  static const Color blackColor = Color(0xFF242E30);

  static const Color suggestionAddressColor = Color(0xFF797979);
  static const Color emptyCartIconColor = Color(0xFFF3F3F3);
}
