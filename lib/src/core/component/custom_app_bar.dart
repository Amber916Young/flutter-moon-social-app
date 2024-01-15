import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final BuildContext context;

  const CustomAppBar({Key? key, required this.title, this.isBackButtonExist = true, this.onBackPressed, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)
        ? Center(
            child: Container(
                color: Theme.of(context).cardColor,
                width: 1170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  ],
                )),
          )
        : AppBar(
            title: Text(title!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color)),
            centerTitle: true,
            leading: isBackButtonExist
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.of(context).maybePop(),
                  )
                : const SizedBox(),
            backgroundColor: Theme.of(context).cardColor,
            elevation: 0,
          );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, ResponsiveHelper.isDesktop(context) ? 80 : 50);
}
