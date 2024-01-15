import 'package:flutter/material.dart';
import 'package:moon/main.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';

void showCustomSnackBar(String? message,
    {bool isError = true, bool isToast = false, int duration = 1000}) {
  final width = MediaQuery.of(Get.context!).size.width;
  ScaffoldMessenger.of(Get.context!)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(message!,
          style: textRegular.copyWith(
            color: Colors.white,
          )),
      margin: ResponsiveHelper.isDesktop(Get.context!)
          ? EdgeInsets.only(
              right: width * 0.7,
              bottom: Dimensions.paddingSizeExtraSmall,
              left: Dimensions.paddingSizeExtraSmall)
          : const EdgeInsets.only(
              bottom: Dimensions.paddingSizeExtraExtraLarge,
            ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: Duration(milliseconds: duration),
    ));
}
