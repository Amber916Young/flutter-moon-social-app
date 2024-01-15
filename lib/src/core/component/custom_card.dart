import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';

class CustomCardForm extends StatelessWidget {
  final Widget child;
  const CustomCardForm({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeLarge),
        child: Column(
          children: [
            ResponsiveHelper.isMobile()
                ? const SizedBox()
                : const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
            Center(
                child: Container(
                    width: width > 700 ? 700 : width,
                    margin: width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
                    decoration: width > 700
                        ? BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.radiusExtraSmall),
                            boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
                          )
                        : null,
                    child: Padding(
                      padding: ResponsiveHelper.isMobile() ? const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault) : const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                      child: child,
                    ))),
          ],
        ),
      ),
    ));
  }
}
