import 'package:flutter/material.dart';
import 'package:moon/main.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/route/routes.dart';

class TextWithNumberWidget extends StatelessWidget {
  final String text;
  final String number;

  TextWithNumberWidget({required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(Get.context!, Routes.getMyFriendsScreen());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: textRegular,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Text(
            number,
            style: textBold,
          ),
        ],
      ),
    );
  }
}
