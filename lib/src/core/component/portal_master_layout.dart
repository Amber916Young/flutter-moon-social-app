import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/main.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/route/routes.dart';
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
      Navigator.popAndPushNamed(Get.context!, Routes.getMainRoute());
    } else if (index == 1) {
      // Navigator.popAndPushNamed(Get.context!, Routes.getCartCheckoutViewRoute());
    } else if (index == 2) {
      // Navigator.popAndPushNamed(Get.context!, Routes.getOrderRoute(false));
    } else if (index == 3) {
      Navigator.popAndPushNamed(Get.context!, Routes.getVideoRoute());
    } else if (index == 4) {
      Navigator.popAndPushNamed(Get.context!, Routes.getProfileRoute());
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return PopScope(
  //     canPop: false,
  //     onPopInvoked: (didPop) async {
  //       if (didPop) {
  //         return;
  //       }
  //       final navigator = Navigator.of(context);
  //       // bool value = await someFunction();
  //       // if (value) {
  //       //   navigator.pop();
  //       // }
  //
  //     },
  //     child:
  //     Scaffold(
  //       endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
  //       // endDrawer: EndDrawer(pageIndex: pageIndex),
  //       onEndDrawerChanged: onEndDrawerChanged,
  //       appBar: appBar,
  //       bottomNavigationBar: (!(ResponsiveHelper.isDesktop(context)))
  //           ? Container(
  //         padding: const EdgeInsets.symmetric(vertical: 10),
  //         decoration: BoxDecoration(
  //           color: Theme.of(context).cardColor,
  //           boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 10, spreadRadius: 1)],
  //           borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
  //         ),
  //         height: 80,
  //         child: BottomNavigationBar(
  //           backgroundColor: Theme.of(context).cardColor,
  //           elevation: 0,
  //           selectedItemColor: Theme.of(context).primaryColor,
  //           unselectedItemColor: Theme.of(context).hintColor.withOpacity(0.7),
  //           selectedLabelStyle: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: 10),
  //           unselectedLabelStyle: textMedium.copyWith(color: Theme.of(context).hintColor.withOpacity(0.7), fontSize: 10),
  //           showUnselectedLabels: true,
  //           currentIndex: pageIndex,
  //           type: BottomNavigationBarType.fixed,
  //           items: [
  //             _barItem('assets/svg/menu_icon.svg', getTranslated('home', context), 0),
  //             _barItem('assets/svg/cart_icon.svg', getTranslated('grow_up', context), 1),
  //             _barItem('assets/svg/order_icon.svg', getTranslated('market', context), 2),
  //             _barItem('assets/svg/promo_icon.svg', getTranslated('message', context), 3),
  //             _barItem('assets/svg/profile_icon.svg',getTranslated('my_profile', context) , 4)],
  //           onTap: (index) {
  //             navigation(index);
  //           },
  //         ),
  //       )
  //           : const SizedBox(),
  //       body: body,
  //     ),
  //   );
  // }
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
                      items: [_barItem('assets/svg/menu_icon.svg', getTranslated('home', context), 0), _barItem('assets/svg/cart_icon.svg', getTranslated('grow_up', context), 1), _barItem('assets/svg/order_icon.svg', getTranslated('market', context), 2), _barItem('assets/svg/promo_icon.svg', getTranslated('message', context), 3), _barItem('assets/svg/profile_icon.svg', getTranslated('my_profile', context), 4)],
                      onTap: (index) {
                        navigation(index);
                      },
                    ),
                  )
              : const SizedBox()
          : const SizedBox(),
      body: body,
    );
  }

  BottomNavigationBarItem _barItem(String svgPath, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(svgPath, color: index == pageIndex ? Theme.of(Get.context!).primaryColor : Theme.of(Get.context!).hintColor.withOpacity(0.7), height: 25),
          index == 1
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