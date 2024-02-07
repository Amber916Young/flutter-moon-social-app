import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/main.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/route/app_router.dart';
import 'package:provider/provider.dart';

class PortalMasterLayout extends StatelessWidget {
  final int pageIndex;
  final void Function(bool isOpened)? onEndDrawerChanged;
  final bool endDrawerEnableOpenDragGesture;
  final bool showDrawer;
  final bool showBottomBar;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const PortalMasterLayout({Key? key, this.bottomNavigationBar = null, this.floatingActionButton = null, this.showBottomBar = true, this.showDrawer = false, required this.pageIndex, this.onEndDrawerChanged, this.endDrawerEnableOpenDragGesture = true, this.appBar, required this.body}) : super(key: key);

  void navigation(index) {
    if (pageIndex == index) return;
    if (index == 0) {
      GoRouter.of(
        Get.context!,
      ).go(RouteUri.home);
    } else if (index == 1) {
      // GoRouter.of(
      //   Get.context!,
      // ).go(RouteUri.home);
    } else if (index == 2) {
      GoRouter.of(
        Get.context!,
      ).go(RouteUri.videoScreen);
    } else if (index == 3) {
      GoRouter.of(
        Get.context!,
      ).go(RouteUri.notification);
    } else if (index == 4) {
      GoRouter.of(
        Get.context!,
      ).go(RouteUri.myProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      // endDrawer: EndDrawer(pageIndex: pageIndex),
      onEndDrawerChanged: onEndDrawerChanged,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: (!(ResponsiveHelper.isDesktop(context)))
          ? showBottomBar
              ? bottomNavigationBar ??
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      boxShadow: [BoxShadow(color: Theme.of(context).primaryColorLight.withOpacity(0.3), blurRadius: 10, spreadRadius: 1)],
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 0,
                      selectedItemColor: Theme.of(context).primaryColor,
                      unselectedItemColor: Theme.of(context).hintColor.withOpacity(0.7),
                      selectedLabelStyle: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: 10),
                      unselectedLabelStyle: textMedium.copyWith(color: Theme.of(context).hintColor.withOpacity(0.7), fontSize: 10),
                      showUnselectedLabels: true,
                      currentIndex: pageIndex,
                      type: BottomNavigationBarType.fixed,
                      items: [_barItem(Icons.menu_book_rounded, getTranslated('home', context), 0), _barItem(Icons.video_chat_rounded, getTranslated('grow_up', context), 1), _barItem(Icons.local_mall_rounded, getTranslated('market', context), 2), _barItem(Icons.people_alt_rounded, getTranslated('message', context), 3), _barItem(Icons.person_outline_rounded, getTranslated('my_profile', context), 4)],
                      onTap: (index) {
                        navigation(index);
                      },
                    ),
                  )
              : const SizedBox()
          : const SizedBox(),
      body: SafeArea(
        child: body,
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData svgPath, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            svgPath,
            color: index == pageIndex ? Theme.of(Get.context!).primaryColor : Theme.of(Get.context!).hintColor.withOpacity(0.7),
          ),
          // SvgPicture.asset(svgPath, color: index == pageIndex ? Theme.of(Get.context!).primaryColor : Theme.of(Get.context!).hintColor.withOpacity(0.7), height: 25),
          index == 3
              ? Positioned(
                  top: -7,
                  right: -7,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                    child: Text(
                      "12",
                      style: textMedium.copyWith(color: Colors.white, fontSize: 8),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      label: label,
    );
  }
}
