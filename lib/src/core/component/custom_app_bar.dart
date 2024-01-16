import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final bool hasAction;
  final bool hasLeading;
  final Function? onBackPressed;
  final BuildContext context;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final Widget? flexibleSpace;
  const CustomAppBar({Key? key, this.flexibleSpace, required this.title, this.leadingWidget, this.actions, this.hasLeading = false, this.hasAction = false, this.isBackButtonExist = true, this.onBackPressed, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)
        ? Center(
            child: Container(
                color: Theme.of(context).cardColor,
                width: 1170,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                )),
          )
        : AppBar(
            title: Text(title ?? "", style: Theme.of(context).textTheme.titleMedium),
            centerTitle: true,
            actions: actions,
            leading: hasLeading
                ? leadingWidget
                : isBackButtonExist
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.of(context).maybePop(),
                      )
                    : const SizedBox(),
            elevation: 0,
            flexibleSpace: flexibleSpace,
          );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, ResponsiveHelper.isDesktop(context) ? 80 : 50);
}
