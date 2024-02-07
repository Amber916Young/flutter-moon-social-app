import 'package:flutter/material.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';

class CustomCardForm extends StatelessWidget {
  final Widget child;
  final Function? onBackPressed;
  final Function? onRefreshPressed;
  final bool? showRefresh;
  final bool? showBack;
  final bool isScroll;
  final bool hasBackColor;

  const CustomCardForm({Key? key, required this.child, this.hasBackColor = true, this.showBack = true, this.isScroll = true, this.showRefresh = false, this.onBackPressed, this.onRefreshPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: ResponsiveHelper.isDesktop(context)
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    child: Column(
                      children: [
                        // CustomBackBar(
                        //   onBackPressed: onBackPressed,
                        //   context: context,
                        //   showBack: showBack,
                        //   showRefresh: showRefresh,
                        //   onRefreshPressed: () {
                        //     if (onRefreshPressed != null) {
                        //       onRefreshPressed!();
                        //     }
                        //   },
                        // ),
                        Center(
                            child: Container(
                                width: width > 700 ? 700 : width,
                                margin: width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeExtraSmall) : null,
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                decoration: width > 700
                                    ? hasBackColor
                                        ? BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            // borderRadius: BorderRadius.circular(Dimensions.radiusExtraSmall),
                                            // boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
                                          )
                                        : null
                                    : null,
                                child: child)),
                      ],
                    )))
            : (isScroll)
                ? SingleChildScrollView(
                    child: Center(
                        child: Container(
                      width: width > 700 ? 700 : width,
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      padding: EdgeInsets.zero,
                      child: child,
                    )),
                  )
                : Center(
                    child: Container(
                    width: width > 700 ? 700 : width,
                    padding: EdgeInsets.zero,
                    child: child,
                  )));
  }
}
